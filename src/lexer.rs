use miette::{Diagnostic, NamedSource, Result, SourceSpan};

use logos::Logos;

use crate::located::Span;

#[derive(Debug, Diagnostic, thiserror::Error, PartialEq, Clone, Default)]
pub enum LexingError {
    #[error("expected a valid token")]
    UnknownToken {
        #[label("here")]
        span: SourceSpan,
    },
    #[default]
    #[error("Something went wrong")]
    Other,
}

impl LexingError {
    fn from_lexer<'src>(lex: &mut logos::Lexer<'src, TokenKind>) -> Self {
        LexingError::UnknownToken {
            span: lex.span().into(),
        }
    }

    fn error<'src>(lex: &mut logos::Lexer<'src, TokenKind>) -> Result<(), Self> {
        Err(Self::from_lexer(lex))
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy, Logos)]
#[logos(error(LexingError, LexingError::from_lexer))]
pub enum TokenKind {
    #[regex(r"[a-zA-Z_]\w*")]
    Identifier,
    #[regex(r"\d+")]
    Constant,
    #[regex(r"\d+[a-zA-Z_]", LexingError::error)]
    InvalidIdentifier,
    #[token("(")]
    LParen,
    #[token(")")]
    RParen,
    #[token("{")]
    LBrace,
    #[token("}")]
    RBrace,
    #[token("int")]
    Int,
    #[token("void")]
    Void,
    #[regex(r"return")]
    Return,
    #[token(";")]
    Semicolon,
    #[regex(r"\s+")]
    Whitespace,
    #[token("~")]
    Tilde,
    #[token("-")]
    Hypen,
    #[token("+")]
    Plus,
    #[token("*")]
    Asterisk,
    #[token("/")]
    FSlash,
    #[token("%")]
    Percent,
    #[token("&")]
    Ampersand,
    #[token("|")]
    Pipe,
    #[token("^")]
    Caret,
    #[token("<<")]
    ShLeft,
    #[token(">>")]
    ShRight,
    #[token("!")]
    Exclamation,
    #[token("==")]
    DoubleEquals,
    #[token("&&")]
    DoubleAnd,
    #[token("||")]
    DoublePipe,
    #[token("!=")]
    NotEqual,
    #[token("<")]
    Less,
    #[token(">")]
    Greater,
    #[token("<=")]
    LessEqual,
    #[token(">=")]
    GreaterEqual,
    #[token("=")]
    Equals,
    #[token("++")]
    PlusPlus,
    #[token("--")]
    MinusMinus,
    #[token("+=")]
    PlusEquals,
    #[token("-=")]
    MinusEquals,
    #[token("*=")]
    TimesEquals,
    #[token("/=")]
    DivEquals,
    #[token("%=")]
    ModEquals,
    #[token("&=")]
    AndEquals,
    #[token("|=")]
    OrEquals,
    #[token("^=")]
    XorEquals,
    #[token(">>=")]
    ShiftRightEquals,
    #[token("<<=")]
    ShiftLeftEquals,
    #[token("if")]
    If,
    #[token("else")]
    Else,
    #[token("?")]
    Question,
    #[token(":")]
    Colon,
    #[token("goto")]
    Goto,
    #[token("for")]
    For,
    #[token("while")]
    While,
    #[token("do")]
    Do,
    #[token("break")]
    Break,
    #[token("continue")]
    Continue,
    #[token("switch")]
    Switch,
    #[token("case")]
    Case,
    #[token("default")]
    Default,
    #[token(",")]
    Comma,
}

pub fn lex(source: impl AsRef<str>, name: impl AsRef<str>) -> Result<Vec<(Span, TokenKind)>> {
    TokenKind::lexer(source.as_ref())
        .spanned()
        .map(|(kind, range)| {
            kind.map(|kind| (range.into(), kind)).map_err(|e| {
                miette::Report::from(e).with_source_code(
                    NamedSource::new(name.as_ref(), source.as_ref().to_string()).with_language("c"),
                )
            })
        })
        .filter(|t| !matches!(t, Ok((_, TokenKind::Whitespace,))))
        .collect()
}

#[cfg(test)]
mod tests {

    use crate::lexer::lex;

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
        assert_eq!(tokens, vec![((0, 3).into(), crate::lexer::TokenKind::Int)]);
        let tokens = lex(" int", "example.c").unwrap();
        assert_eq!(tokens, vec![((1, 3).into(), crate::lexer::TokenKind::Int)]);
        let tokens = lex("int ", "example.c").unwrap();
        assert_eq!(tokens, vec![((0, 3).into(), crate::lexer::TokenKind::Int)]);
    }

    #[test]
    fn test_lex_main() {
        let tokens = lex("int main(void) {\n  return 2;\n}\n", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![
                ((0, 3).into(), crate::lexer::TokenKind::Int),
                ((4, 4).into(), crate::lexer::TokenKind::Identifier),
                ((8, 1).into(), crate::lexer::TokenKind::LParen),
                ((9, 4).into(), crate::lexer::TokenKind::Void),
                ((13, 1).into(), crate::lexer::TokenKind::RParen),
                ((15, 1).into(), crate::lexer::TokenKind::LBrace),
                ((19, 6).into(), crate::lexer::TokenKind::Return),
                ((26, 1).into(), crate::lexer::TokenKind::Constant),
                ((27, 1).into(), crate::lexer::TokenKind::Semicolon),
                ((29, 1).into(), crate::lexer::TokenKind::RBrace),
            ]
        );
    }

    #[test]
    fn test_lex_invalid_ident() {
        lex("1foo$", "example.c").expect_err("1foo should fail to lex");
    }

    #[test]
    fn test_lex_at() {
        lex("0@1", "example.c").expect_err("1foo should fail to lex");
    }
}
