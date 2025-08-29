use miette::{Diagnostic, NamedSource, Result, SourceSpan};

use logos::Logos;

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
    fn from_lexer<'src>(lex: &mut logos::Lexer<'src, Token>) -> Self {
        LexingError::UnknownToken {
            span: lex.span().into(),
        }
    }

    fn error<'src, T>(lex: &mut logos::Lexer<'src, Token>) -> Result<T, Self> {
        Err(Self::from_lexer(lex))
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Logos, Copy)]
#[logos(error(LexingError, LexingError::from_lexer))]
pub enum Token {
    #[regex(r"[a-zA-Z_]\w*")]
    Identifier,
    #[regex(r"\d+([uU][lL]|[lL][uU]|[uU]|[lL])?", priority = 5)]
    Constant,
    #[regex(r"\d+[a-zA-Z_]\w*", |lex| LexingError::error::<()>(lex))]
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
    #[token("long")]
    Long,
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
    #[token("static")]
    Static,
    #[token("extern")]
    Extern,
    #[token("signed")]
    Signed,
    #[token("unsigned")]
    Unsigned,
}

pub fn lex(source: impl AsRef<str>, filename: impl AsRef<str>) -> Result<Vec<(Token, SourceSpan)>> {
    Token::lexer(source.as_ref())
        .spanned()
        .map(|(token, span)| {
            token.map(|t| (t, span.into())).map_err(|e| {
                miette::Report::from(e).with_source_code(NamedSource::new(
                    filename.as_ref(),
                    source.as_ref().to_string(),
                ))
            })
        })
        .filter(|res| !matches!(res, Ok((Token::Whitespace, _))))
        .collect()
}

#[cfg(test)]
mod tests {

    use crate::lexer::{Token::*, lex};

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
        assert_eq!(tokens, vec![(Int, (0, 3).into())]);
        let tokens = lex(" int", "example.c").unwrap();
        assert_eq!(tokens, vec![(Int, (1, 3).into())]);
        let tokens = lex("int ", "example.c").unwrap();
        assert_eq!(tokens, vec![(Int, (0, 3).into())]);
    }

    #[test]
    fn test_lex_main() {
        let tokens = lex("int main(void) {\n  return 2;\n}\n", "example.c").unwrap();
        assert_eq!(
            tokens,
            vec![
                (Int, (0, 3).into()),
                (Identifier, (4, 4).into()),
                (LParen, (8, 1).into()),
                (Void, (9, 4).into()),
                (RParen, (13, 1).into()),
                (LBrace, (15, 1).into()),
                (Return, (19, 6).into()),
                (Constant, (26, 1).into()),
                (Semicolon, (27, 1).into()),
                (RBrace, (29, 1).into()),
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
