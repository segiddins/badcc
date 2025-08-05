use miette::{LabeledSpan, NamedSource, Result, Severity, SourceSpan, bail};

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum TokenKind {
    Identifier,
    Constant,
    LParen,
    RParen,
    LBrace,
    RBrace,
    Int,
    Void,
    Return,
    Semicolon,
    Whitespace,
    Tilde,
    Hypen,
    Decrement,
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Token {
    pub kind: TokenKind,
    pub location: SourceSpan,
}

impl Token {
    pub fn source<'a>(&self, source: &'a str) -> &'a str {
        source
            .get(self.location.offset()..(self.location.offset() + self.location.len()))
            .unwrap()
    }
}

pub fn lex(source: impl AsRef<str>, name: impl AsRef<str>) -> Result<Vec<Token>> {
    do_lex(source.as_ref()).map_err(|e| {
        e.with_source_code(NamedSource::new(name, source.as_ref().to_string()).with_language("c"))
    })
}

fn do_lex(source: &str) -> Result<Vec<Token>> {
    let mut tokens = vec![];

    let mut pos = 0usize;
    let len = source.len();

    while pos < len {
        let token = lex_token(pos, source)?;
        pos = token.location.offset() + token.location.len();
        if matches!(
            token,
            Token {
                kind: TokenKind::Whitespace,
                ..
            }
        ) {
            continue;
        }
        tokens.push(token);
    }

    Ok(tokens)
}

fn lex_token(pos: usize, source: &str) -> Result<Token> {
    macro_rules! pat {
        ($pattern:expr, $kind:expr) => {
            if let Some(m) = regex::Regex::new($pattern).unwrap().find_at(source, pos)
                && m.start() == pos
            {
                return Ok(Token {
                    kind: $kind,
                    location: m.range().into(),
                });
            }
        };
    }
    pat!(r"int\b", TokenKind::Int);
    pat!(r"void\b", TokenKind::Void);
    pat!(r"return\b", TokenKind::Return);
    pat!(r"\(", TokenKind::LParen);
    pat!(r"\)", TokenKind::RParen);
    pat!(r"\{", TokenKind::LBrace);
    pat!(r"\}", TokenKind::RBrace);
    pat!(r"[a-zA-Z_]\w*\b", TokenKind::Identifier);
    pat!(r"\d+\b", TokenKind::Constant);
    pat!(r";", TokenKind::Semicolon);
    pat!(r"\s+", TokenKind::Whitespace);
    pat!(r"--", TokenKind::Decrement);
    pat!(r"-", TokenKind::Hypen);
    pat!(r"~", TokenKind::Tilde);
    bail!(
        // Those fields are optional
        severity = Severity::Error,
        code = "expected::token",
        labels = vec![LabeledSpan::at_offset(pos, "here")],
        // Rest of the arguments are passed to `format!`
        // to form diagnostic message
        "expected a token"
    );
}

#[cfg(test)]
mod tests {

    use crate::lexer::{Token, lex};

    #[test]
    fn test_lex_empty() {
        let tokens = lex("", "example.c").unwrap();
        assert_eq!(tokens, Vec::new());

        let tokens = lex(" ", "example.c").unwrap();
        assert_eq!(tokens, Vec::new());
    }

    #[test]
    fn test_lex_int() {
        let tokens = lex("int", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![Token {
                kind: crate::lexer::TokenKind::Int,
                location: (0, 3).into()
            }]
        );
        let tokens = lex(" int", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![Token {
                kind: crate::lexer::TokenKind::Int,
                location: (1, 3).into()
            }]
        );
        let tokens = lex("int ", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![Token {
                kind: crate::lexer::TokenKind::Int,
                location: (0, 3).into()
            }]
        );
    }

    #[test]
    fn test_lex_main() {
        let tokens = lex("int main(void) {\n  return 2;\n}\n", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![
                Token {
                    kind: crate::lexer::TokenKind::Int,
                    location: (0, 3).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::Identifier,
                    location: (4, 4).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::LParen,
                    location: (8, 1).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::Void,
                    location: (9, 4).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::RParen,
                    location: (13, 1).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::LBrace,
                    location: (15, 1).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::Return,
                    location: (19, 6).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::Constant,
                    location: (26, 1).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::Semicolon,
                    location: (27, 1).into()
                },
                Token {
                    kind: crate::lexer::TokenKind::RBrace,
                    location: (29, 1).into()
                },
            ]
        );
    }

    #[test]
    fn test_lex_invalid_ident() {
        lex("1foo", "example.c").expect_err("1foo should fail to lex");
    }

    #[test]
    fn test_lex_at() {
        lex("0@1", "example.c").expect_err("1foo should fail to lex");
    }
}
