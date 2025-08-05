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
    UnaryOperation(UnaryOperator, Box<Expression>),
}

#[derive(Debug)]
pub enum UnaryOperator {
    Minus,
    Complement,
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
    .and_then(|s| {
        tokens.expect(TokenKind::Semicolon)?;
        Ok(s)
    })
}

fn parse_expression<'i>(source: &str, tokens: &mut Tokens<'i>) -> Result<Expression> {
    match tokens.next_token() {
        Some(token) => match token.kind {
            TokenKind::Constant => token
                .source(source)
                .parse()
                .into_diagnostic()
                .map(Expression::Constant),
            TokenKind::Hypen => parse_expression(source, tokens)
                .map(|e| Expression::UnaryOperation(UnaryOperator::Minus, Box::new(e))),
            TokenKind::Tilde => parse_expression(source, tokens)
                .map(|e| Expression::UnaryOperation(UnaryOperator::Complement, Box::new(e))),

            TokenKind::LParen => parse_expression(source, tokens).and_then(|e| {
                tokens.expect(TokenKind::RParen)?;
                Ok(e)
            }),

            _ => bail!(
                labels = vec![LabeledSpan::at(token.location, "here")],
                "expected expression"
            ),
        },
        None => bail!("unexpected EOF"),
    }
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
