use std::str::FromStr;

use miette::{LabeledSpan, NamedSource, Result, bail, miette};
use winnow::{prelude::*, stream::TokenSlice};

use crate::lexer::{Token, TokenKind};

#[derive(Debug)]
pub struct Program {
    pub function: Function,
}

#[derive(Debug)]
pub enum Expression {
    Constant(i32),
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
    tokens.expect(TokenKind::Return)?;
    let constant: i32 = tokens.parse(TokenKind::Constant, source)?;
    tokens.expect(TokenKind::Semicolon)?;
    tokens.expect(TokenKind::RBrace)?;

    Ok(Program {
        function: Function {
            identifier: name.to_string(),
            statement: Statement::Return(Expression::Constant(constant)),
        },
    })
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
