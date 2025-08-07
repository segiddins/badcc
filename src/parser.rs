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
    Var(String),
    Assignment(Box<Expression>, Box<Expression>),
}

#[derive(Debug)]
pub enum UnaryOperator {
    Minus,
    Complement,
    Not,
}

#[derive(Debug, Clone, Copy)]
pub enum BinaryOperator {
    Add,
    Subtract,
    Multiply,
    Divide,
    Remainder,
    LeftShift,
    RightShift,
    BitwiseOr,
    BitwiseAnd,
    Xor,
    Equals,
    LessThan,
    LessThanOrEqual,
    GreaterThan,
    GreaterThanOrEqual,
    NotEqual,
    And,
    Or,
}

#[derive(Debug)]
pub enum Statement {
    Return(Expression),
    Expression(Expression),
    Null,
}

#[derive(Debug)]

pub struct VariableDeclaration {
    pub name: String,
    pub init: Option<Expression>,
}

#[derive(Debug)]
pub enum BlockItem {
    Statement(Statement),
    Declaration(VariableDeclaration),
}

#[derive(Debug)]
pub struct Function {
    pub name: String,
    pub body: Vec<BlockItem>,
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
    Ok(Program {
        function: parse_function(lexer)?,
    })
}

fn parse_function(lexer: &mut Lexer) -> Result<Function> {
    lexer.expect(TokenKind::Int)?;
    let name = lexer.expect(TokenKind::Identifier)?.source(lexer.source);
    lexer.expect(TokenKind::LParen)?;
    lexer.expect(TokenKind::Void)?;
    lexer.expect(TokenKind::RParen)?;
    lexer.expect(TokenKind::LBrace)?;
    let mut body = vec![];
    while !matches!(
        lexer.peek_token(),
        Some(Token {
            kind: TokenKind::RBrace,
            ..
        })
    ) {
        body.push(parse_block_item(lexer)?);
    }
    lexer.expect(TokenKind::RBrace)?;

    Ok(Function {
        name: name.to_owned(),
        body,
    })
}

fn parse_block_item(lexer: &mut Lexer) -> Result<BlockItem> {
    match lexer.peek_token() {
        Some(Token {
            kind: TokenKind::Int,
            ..
        }) => parse_declaration(lexer).map(BlockItem::Declaration),
        _ => parse_statement(lexer).map(BlockItem::Statement),
    }
}

fn parse_declaration(lexer: &mut Lexer) -> Result<VariableDeclaration> {
    lexer.expect(TokenKind::Int)?;
    let name = lexer.expect(TokenKind::Identifier)?.source(lexer.source);

    let init = match lexer.peek_token() {
        Some(Token {
            kind: TokenKind::Equals,
            ..
        }) => {
            lexer.expect(TokenKind::Equals)?;
            Some(parse_expression(lexer)?)
        }
        _ => None,
    };

    lexer.expect(TokenKind::Semicolon)?;

    Ok(VariableDeclaration {
        name: name.to_string(),
        init,
    })
}

fn parse_statement(lexer: &mut Lexer) -> Result<Statement> {
    match lexer.peek_token() {
        Some(token) => match token.kind {
            TokenKind::Return => lexer
                .expect(TokenKind::Return)
                .and_then(|_| Ok(Statement::Return(parse_expression(lexer)?))),
            TokenKind::Semicolon => Ok(Statement::Null),
            _ => parse_expression(lexer).map(Statement::Expression),
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
        TokenKind::Exclamation => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Not, Box::new(e))),
        TokenKind::Identifier => Ok(Expression::Var(token.source(lexer.source).to_string())),
        _ => {
            bail!(
                labels = vec![LabeledSpan::at(token.location, "here")],
                "expected expression"
            )
        }
    }?;

    loop {
        let (op, r_bp) = match lexer.peek_token().map(|t| t.kind) {
            Some(TokenKind::Equals) if min_bp <= 1 => {
                lexer.next_token();
                let rhs = parse_expression_bp(lexer, 1)?;
                lhs = Expression::Assignment(Box::new(lhs), Box::new(rhs));
                break;
            }
            Some(TokenKind::DoublePipe) => (BinaryOperator::Or, 5),
            Some(TokenKind::DoubleAnd) => (BinaryOperator::And, 10),
            Some(TokenKind::Pipe) => (BinaryOperator::BitwiseOr, 25),
            Some(TokenKind::Caret) => (BinaryOperator::Xor, 30),
            Some(TokenKind::Ampersand) => (BinaryOperator::BitwiseAnd, 35),
            Some(TokenKind::NotEqual) => (BinaryOperator::NotEqual, 36),
            Some(TokenKind::DoubleEquals) => (BinaryOperator::Equals, 36),
            Some(TokenKind::Less) => (BinaryOperator::LessThan, 38),
            Some(TokenKind::LessEqual) => (BinaryOperator::LessThanOrEqual, 38),
            Some(TokenKind::Greater) => (BinaryOperator::GreaterThan, 38),
            Some(TokenKind::GreaterEqual) => (BinaryOperator::GreaterThanOrEqual, 38),
            Some(TokenKind::ShRight) => (BinaryOperator::RightShift, 40),
            Some(TokenKind::ShLeft) => (BinaryOperator::LeftShift, 40),
            Some(TokenKind::Plus) => (BinaryOperator::Add, 45),
            Some(TokenKind::Hypen) => (BinaryOperator::Subtract, 45),
            Some(TokenKind::Asterisk) => (BinaryOperator::Multiply, 50),
            Some(TokenKind::FSlash) => (BinaryOperator::Divide, 50),
            Some(TokenKind::Percent) => (BinaryOperator::Remainder, 50),
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
                name: "main",
                body: [
                    Statement(
                        Return(
                            Constant(
                                2,
                            ),
                        ),
                    ),
                ],
            },
        }
        "#);
        Ok(())
    }

    #[test]
    fn test_statement_types() -> miette::Result<()> {
        let src = "int main(void) { 1+1; ; ; return 2; }";
        let tokens = lex(src, "example.c")?;
        let program = parse(src, tokens, "example.c")?;
        insta::assert_debug_snapshot!(program, @r#"
        Program {
            function: Function {
                name: "main",
                body: [
                    Statement(
                        Expression(
                            Binary(
                                Add,
                                Constant(
                                    1,
                                ),
                                Constant(
                                    1,
                                ),
                            ),
                        ),
                    ),
                    Statement(
                        Null,
                    ),
                    Statement(
                        Null,
                    ),
                    Statement(
                        Return(
                            Constant(
                                2,
                            ),
                        ),
                    ),
                ],
            },
        }
        "#);
        Ok(())
    }
}
