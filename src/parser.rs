use std::str::FromStr;

use miette::{IntoDiagnostic, LabeledSpan, NamedSource, Result, bail, miette};
use winnow::{prelude::*, stream::TokenSlice};

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

pub(crate) type Tokens<'i> = TokenSlice<'i, Token>;

trait ParserTokens {
    fn expect(&mut self, kind: TokenKind) -> Result<&Token>;
    fn parse<T: FromStr>(&mut self, kind: TokenKind, source: &str) -> Result<T>
    where
        <T as FromStr>::Err: std::error::Error + Send + Sync + 'static;
}

impl ParserTokens for Tokens<'_> {
    fn expect(&mut self, kind: TokenKind) -> Result<&Token> {
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

    fn parse<T: FromStr>(&mut self, kind: TokenKind, source: &str) -> Result<T>
    where
        <T as FromStr>::Err: std::error::Error + Send + Sync + 'static,
    {
        let token = self.expect(kind)?;
        token.source(source).parse::<T>().map_err(|e| miette!(e))
    }
}

pub fn parse(source: impl AsRef<str>, tokens: &[Token], filename: &str) -> Result<Program> {
    let mut tokens = Tokens::new(tokens);
    parse_program(source.as_ref(), &mut tokens)
        .and_then(|program| {
            if let Some(tok) = tokens.next_token() {
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

fn parse_program<'i>(source: &str, tokens: &mut Tokens<'i>) -> Result<Program> {
    tokens.expect(TokenKind::Int)?;
    let name = tokens.expect(TokenKind::Identifier)?.source(source);
    tokens.expect(TokenKind::LParen)?;
    tokens.expect(TokenKind::Void)?;
    tokens.expect(TokenKind::RParen)?;
    tokens.expect(TokenKind::LBrace)?;
    let statement = parse_statement(source, tokens)?;
    tokens.expect(TokenKind::RBrace)?;

    Ok(Program {
        function: Function {
            identifier: name.to_string(),
            statement,
        },
    })
}

fn parse_statement<'i>(source: &str, tokens: &mut Tokens<'i>) -> Result<Statement> {
    match tokens.next_token() {
        Some(token) => match token.kind {
            TokenKind::Return => Ok(Statement::Return(parse_expression(source, tokens)?)),
            _ => bail!("expected statement"),
        },
        None => bail!("unexpected EOF"),
    }
    .and_then(|s: Statement| {
        tokens.expect(TokenKind::Semicolon)?;
        Ok(s)
    })
}

fn parse_expression<'i>(source: &str, tokens: &mut Tokens<'i>) -> Result<Expression> {
    parse_expression_bp(source, tokens, 0)
}

fn parse_expression_bp<'i>(
    source: &str,
    tokens: &mut Tokens<'i>,
    min_bp: u8,
) -> Result<Expression> {
    let Some(token) = tokens.next_token() else {
        bail!("unexpected eof")
    };
    let mut lhs = match token.kind {
        TokenKind::Constant => token
            .source(source)
            .parse()
            .map(Expression::Constant)
            .into_diagnostic(),

        TokenKind::LParen => parse_expression_bp(source, tokens, 0).and_then(|e| {
            tokens.expect(TokenKind::RParen)?;
            Ok(e)
        }),
        TokenKind::Hypen => parse_expression_bp(source, tokens, 60).map(|e| Expression::Unary(UnaryOperator::Minus, Box::new(e))),
        TokenKind::Tilde => parse_expression_bp(source, tokens, 60).map(|e| Expression::Unary(UnaryOperator::Complement, Box::new(e))),
        _ => {
            bail!(
                labels = vec![LabeledSpan::at(token.location, "here")],
                "expected expression"
            )
        }
    }?;

    loop {
        let (op, r_bp) = match tokens.peek_token() {
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
        tokens.next_token();
        lhs = Expression::Binary(
            op,
            Box::new(lhs),
            Box::new(parse_expression_bp(source, tokens, r_bp + 1)?),
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
        let program = parse(src, &tokens, "example.c")?;
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
