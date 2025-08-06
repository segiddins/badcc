use miette::{IntoDiagnostic, LabeledSpan, NamedSource, Result, bail};

use crate::lexer::{Token, TokenKind};

#[derive(Debug)]
pub struct Program {
    pub function: Function,
}

#[derive(Debug)]
pub enum Expression {
    Constant(i32),
    Unary(UnaryOperator, Box<Expression>),
    Binary(BinaryOperator, Box<Expression>, Box<Expression>),
}

#[derive(Debug)]
pub enum UnaryOperator {
    Minus,
    Complement,
}

#[derive(Debug, Clone, Copy)]
pub enum BinaryOperator {
    Add,
    Subtract,
    Multiply,
    Divide,
    Remainder,
}

#[derive(Debug)]
pub enum Statement {
    Return(Expression),
}

#[derive(Debug)]
pub struct Function {
    pub identifier: String,
    pub statement: Statement,
}

struct Lexer<'i> {
    source: &'i str,
    tokens: Vec<Token>,
}

impl Lexer<'_> {
    fn next_token(&mut self) -> Option<Token> {
        self.tokens.pop()
    }
    fn peek_token(&mut self) -> Option<&Token> {
        self.tokens.last()
    }

    fn expect(&mut self, kind: TokenKind) -> Result<Token> {
        let token = self.next_token().ok_or_else(|| miette::miette!("EOF"))?;
        if token.kind != kind {
            bail!(
                labels = vec![LabeledSpan::at(
                    token.location,
                    format!("unexpected: {:?}", token.kind)
                )],
                "expected {kind:?}"
            );
        }
        Ok(token)
    }
}

pub fn parse(source: impl AsRef<str>, mut tokens: Vec<Token>, filename: &str) -> Result<Program> {
    tokens.reverse();
    let mut lexer = Lexer {
        source: source.as_ref(),
        tokens,
    };
    parse_program(&mut lexer)
        .and_then(|program| {
            if let Some(tok) = lexer.next_token() {
                bail!(
                    code = "expected::eof",
                    labels = vec![LabeledSpan::at(
                        tok.location,
                        format!("found {:?}", tok.kind)
                    )],
                    "expected EOF"
                );
            }
            Ok(program)
        })
        .map_err(|e| e.with_source_code(NamedSource::new(filename, source.as_ref().to_string())))
}

fn parse_program(lexer: &mut Lexer) -> Result<Program> {
    lexer.expect(TokenKind::Int)?;
    let name = lexer.expect(TokenKind::Identifier)?.source(lexer.source);
    lexer.expect(TokenKind::LParen)?;
    lexer.expect(TokenKind::Void)?;
    lexer.expect(TokenKind::RParen)?;
    lexer.expect(TokenKind::LBrace)?;
    let statement = parse_statement(lexer)?;
    lexer.expect(TokenKind::RBrace)?;

    Ok(Program {
        function: Function {
            identifier: name.to_string(),
            statement,
        },
    })
}

fn parse_statement(lexer: &mut Lexer) -> Result<Statement> {
    match lexer.next_token() {
        Some(token) => match token.kind {
            TokenKind::Return => Ok(Statement::Return(parse_expression(lexer)?)),
            _ => bail!("expected statement"),
        },
        None => bail!("unexpected EOF"),
    }
    .and_then(|s: Statement| {
        lexer.expect(TokenKind::Semicolon)?;
        Ok(s)
    })
}

fn parse_expression(lexer: &mut Lexer) -> Result<Expression> {
    parse_expression_bp(lexer, 0)
}

fn parse_expression_bp(lexer: &mut Lexer, min_bp: u8) -> Result<Expression> {
    let Some(token) = lexer.next_token() else {
        bail!("unexpected eof")
    };
    let mut lhs = match token.kind {
        TokenKind::Constant => token
            .source(lexer.source)
            .parse()
            .map(Expression::Constant)
            .into_diagnostic(),

        TokenKind::LParen => parse_expression_bp(lexer, 0).and_then(|e| {
            lexer.expect(TokenKind::RParen)?;
            Ok(e)
        }),
        TokenKind::Hypen => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Minus, Box::new(e))),
        TokenKind::Tilde => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Complement, Box::new(e))),
        _ => {
            bail!(
                labels = vec![LabeledSpan::at(token.location, "here")],
                "expected expression"
            )
        }
    }?;

    loop {
        let (op, r_bp) = match lexer.peek_token() {
            Some(Token {
                kind: TokenKind::Plus,
                ..
            }) => (BinaryOperator::Add, 45),
            Some(Token {
                kind: TokenKind::Hypen,
                ..
            }) => (BinaryOperator::Subtract, 45),
            Some(Token {
                kind: TokenKind::Asterisk,
                ..
            }) => (BinaryOperator::Multiply, 50),
            Some(Token {
                kind: TokenKind::FSlash,
                ..
            }) => (BinaryOperator::Divide, 50),
            Some(Token {
                kind: TokenKind::Percent,
                ..
            }) => (BinaryOperator::Remainder, 50),
            _ => break,
        };
        if r_bp < min_bp {
            break;
        }
        lexer.next_token();
        lhs = Expression::Binary(
            op,
            Box::new(lhs),
            Box::new(parse_expression_bp(lexer, r_bp + 1)?),
        );
    }
    Ok(lhs)
}

#[cfg(test)]
mod tests {
    use crate::{lexer::lex, parser::parse};

    #[test]
    fn test_return_2() -> miette::Result<()> {
        let src = "int main(void) { return 2; }";
        let tokens = lex(src, "example.c")?;
        let program = parse(src, tokens, "example.c")?;
        insta::assert_debug_snapshot!(program, @r#"
        Program {
            function: Function {
                identifier: "main",
                statement: Return(
                    Constant(
                        2,
                    ),
                ),
            },
        }
        "#);
        Ok(())
    }
}
