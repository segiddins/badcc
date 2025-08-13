use std::{borrow::Borrow, num::ParseIntError};

use miette::NamedSource;

pub use crate::ast::*;
use crate::{lexer::TokenKind, located::Span};

impl Borrow<dyn miette::Diagnostic + 'static> for Box<ParserError> {
    fn borrow(&self) -> &(dyn miette::Diagnostic + 'static) {
        self.as_ref()
    }
}

#[derive(Debug, thiserror::Error, miette::Diagnostic)]
#[error("Failed to parse")]
enum ParserError {
    #[error("while parsing {kind}")]
    #[allow(dead_code)]
    Nested {
        #[source]
        #[diagnostic_source]
        nested: Box<ParserError>,

        kind: &'static str,
        #[label("starting here")]
        start: Span,
    },

    #[error("unexpectedly encountered the end of the file")]
    UnexpectedEOF,

    #[error("expected one of {options:?}, found {kind:?}")]
    Expected {
        options: Vec<TokenKind>,
        kind: TokenKind,
        #[label("here")]
        span: Span,
    },

    #[error("found extra tokens at the end of the program")]
    ExtraToken {
        #[label("here")]
        span: Span,
    },

    #[error("integer constant is out of range")]
    ConstantOutOfRange {
        #[source]
        error: ParseIntError,

        #[label("here")]
        span: Span,
    },
}

type Result<T> = std::result::Result<T, ParserError>;

struct Lexer<'i> {
    source: &'i str,
    tokens: Vec<(Span, TokenKind)>,
}

impl Lexer<'_> {
    fn next_token(&mut self) -> Option<(Span, TokenKind)> {
        self.tokens.pop()
    }
    fn peek_token(&self) -> Option<TokenKind> {
        self.tokens.last().map(|t| t.1)
    }
    fn peek_n(&self, n: usize) -> Option<TokenKind> {
        if n > self.tokens.len() {
            return None;
        }
        self.tokens.get(self.tokens.len() - n).map(|t| t.1)
    }

    fn expect_identifier(&mut self) -> Result<String> {
        self.expect(TokenKind::Identifier)
            .map(|span| self.source[span.range()].to_string())
    }

    fn expect(&mut self, kind: TokenKind) -> Result<Span> {
        if self.tokens.is_empty() {
            return Err(ParserError::UnexpectedEOF);
        }
        self.tokens
            .pop_if(|(_, t)| *t == kind)
            .ok_or_else(|| {
                let token = self.tokens.last().unwrap();
                ParserError::Expected {
                    options: vec![kind],
                    kind: token.1,
                    span: token.0.clone().into(),
                }
            })
            .map(|(span, _)| span)
    }

    fn peek_kind(&self, kind: TokenKind) -> bool {
        self.peek_token().is_some_and(|t| t == kind)
    }
}

pub fn parse(
    source: impl AsRef<str>,
    mut tokens: Vec<(Span, TokenKind)>,
    filename: &str,
) -> miette::Result<Program> {
    tokens.reverse();
    let mut lexer = Lexer {
        source: source.as_ref(),
        tokens,
    };
    parse_program(&mut lexer)
        .and_then(|program| {
            if let Some(tok) = lexer.next_token() {
                return Err(ParserError::ExtraToken { span: tok.0 });
            }
            Ok(program)
        })
        .map_err(|e| {
            miette::Report::from(e)
                .with_source_code(NamedSource::new(filename, source.as_ref().to_string()))
        })
}

fn parse_program(lexer: &mut Lexer) -> Result<Program> {
    let mut declarations = vec![];
    while lexer.peek_token().is_some() {
        declarations.push(parse_declaration(lexer)?);
    }
    Ok(Program {
        declarations,
        file_name: "".to_string(),
        contents: lexer.source.into(),
    })
}

fn parse_block(lexer: &mut Lexer) -> Result<Block> {
    lexer.expect(TokenKind::LBrace)?;
    let mut items = vec![];
    while !matches!(lexer.peek_token(), Some(TokenKind::RBrace)) {
        items.push(parse_block_item(lexer)?);
    }
    lexer.expect(TokenKind::RBrace)?;
    Ok(Block { items })
}

fn parse_block_item(lexer: &mut Lexer) -> Result<BlockItem> {
    match lexer.peek_kind(TokenKind::Int) {
        true => parse_declaration(lexer).map(BlockItem::Declaration),
        _ => parse_statement(lexer).map(BlockItem::Statement),
    }
}

fn parse_variable_declaration(lexer: &mut Lexer) -> Result<VariableDeclaration> {
    lexer.expect(TokenKind::Int)?;
    let name = lexer.expect_identifier()?;

    let init = match lexer.peek_token() {
        Some(TokenKind::Equals) => {
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

fn parse_declaration(lexer: &mut Lexer) -> Result<Declaration> {
    if lexer
        .peek_n(3)
        .is_some_and(|t| t == TokenKind::Semicolon || t == TokenKind::Equals)
    {
        return parse_variable_declaration(lexer).map(Declaration::Variable);
    }
    lexer.expect(TokenKind::Int)?;
    let identifier = lexer.expect_identifier()?;

    lexer.expect(TokenKind::LParen)?;

    let mut params = vec![];
    if lexer.peek_token().is_some_and(|t| t == TokenKind::Void) {
        lexer.next_token();
    } else if lexer.peek_kind(TokenKind::RParen) {
    } else {
        lexer.expect(TokenKind::Int)?;
        params.push(lexer.expect_identifier()?);
        while lexer.expect(TokenKind::Comma).is_ok() {
            lexer.expect(TokenKind::Int)?;
            params.push(lexer.expect_identifier()?);
        }
    }

    lexer.expect(TokenKind::RParen)?;

    let body = if lexer.peek_kind(TokenKind::LBrace) {
        Some(parse_block(lexer)?)
    } else {
        lexer.expect(TokenKind::Semicolon)?;
        None
    };
    Ok(Declaration::Function(FunctionDeclaration {
        identifier,
        params,
        body,
    }))
}

fn parse_optional_expression(lexer: &mut Lexer, end: TokenKind) -> Result<Option<Expression>> {
    if lexer.peek_token().is_some_and(|t| t == end) {
        lexer.next_token();
        return Ok(None);
    }

    let expression = parse_expression(lexer)?;
    lexer.expect(end)?;
    Ok(Some(expression))
}

fn parse_for_init(lexer: &mut Lexer) -> Result<ForInit> {
    if lexer.peek_token().is_some_and(|t| t == TokenKind::Int) {
        parse_variable_declaration(lexer).map(ForInit::Decl)
    } else {
        parse_optional_expression(lexer, TokenKind::Semicolon).map(ForInit::Expr)
    }
}

fn parse_statement(lexer: &mut Lexer) -> Result<Statement> {
    match lexer.tokens.last().cloned() {
        Some((_, token)) => match token {
            TokenKind::Return => lexer
                .expect(TokenKind::Return)
                .and_then(|_| Ok(Statement::Return(parse_expression(lexer)?)))
                .and_then(|s| {
                    lexer.expect(TokenKind::Semicolon)?;
                    Ok(s)
                }),
            TokenKind::Semicolon => lexer.expect(TokenKind::Semicolon).map(|_| Statement::Null),
            TokenKind::If => {
                lexer.expect(TokenKind::If)?;
                lexer.expect(TokenKind::LParen)?;
                let cond = parse_expression(lexer)?;
                lexer.expect(TokenKind::RParen)?;
                let then = parse_statement(lexer)?;
                let mut r#else = None;
                if lexer.peek_token().is_some_and(|t| t == TokenKind::Else) {
                    lexer.expect(TokenKind::Else)?;
                    r#else = Some(parse_statement(lexer)?);
                }
                Ok(Statement::If(cond, Box::new(then), r#else.map(Box::new)))
            }
            TokenKind::Identifier if lexer.peek_n(2).map(|t| t) == Some(TokenKind::Colon) => {
                let label = lexer
                    .expect(TokenKind::Identifier)
                    .map(|span| lexer.source[span.range()].to_string())?;
                lexer.expect(TokenKind::Colon)?;
                let statement = parse_statement(lexer)?;
                Ok(Statement::Labeled(label, statement.into()))
            }
            TokenKind::Goto => {
                lexer.expect(TokenKind::Goto)?;
                lexer
                    .expect(TokenKind::Identifier)
                    .map(|span| Statement::Goto(lexer.source[span.range()].to_string()))
                    .and_then(|s| {
                        lexer.expect(TokenKind::Semicolon)?;
                        Ok(s)
                    })
            }
            TokenKind::Switch => {
                lexer.next_token();
                lexer.expect(TokenKind::LParen)?;
                let expr = parse_expression(lexer)?;
                lexer.expect(TokenKind::RParen)?;

                Ok(Statement::Switch(
                    expr,
                    parse_statement(lexer)?.into(),
                    None,
                ))
            }
            TokenKind::LBrace => parse_block(lexer).map(Statement::Compound),
            TokenKind::Case => {
                lexer.next_token();
                let expr = parse_expression(lexer)?;
                lexer.expect(TokenKind::Colon)?;
                Ok(Statement::Case(expr, parse_statement(lexer)?.into(), None))
            }
            TokenKind::Default => {
                lexer.next_token();
                lexer.expect(TokenKind::Colon)?;
                Ok(Statement::Default(parse_statement(lexer)?.into(), None))
            }
            TokenKind::Break => {
                lexer.next_token();
                lexer.expect(TokenKind::Semicolon)?;
                Ok(Statement::Break(None))
            }
            TokenKind::Continue => {
                lexer.next_token();
                lexer.expect(TokenKind::Semicolon)?;
                Ok(Statement::Continue(None))
            }
            TokenKind::While => {
                lexer.next_token();
                lexer.expect(TokenKind::LParen)?;
                let exp = parse_expression(lexer)?;
                lexer.expect(TokenKind::RParen)?;
                parse_statement(lexer).map(|s| Statement::While(exp, s.into(), None))
            }
            TokenKind::Do => {
                lexer.next_token();
                let body = parse_statement(lexer)?;
                lexer.expect(TokenKind::While)?;
                lexer.expect(TokenKind::LParen)?;
                let cond = parse_expression(lexer)?;
                lexer.expect(TokenKind::RParen)?;
                lexer.expect(TokenKind::Semicolon)?;
                Ok(Statement::DoWhile(body.into(), cond, None))
            }
            TokenKind::For => {
                lexer.next_token();
                lexer.expect(TokenKind::LParen)?;
                let init = parse_for_init(lexer)?;
                let condition = parse_optional_expression(lexer, TokenKind::Semicolon)?;
                let post = parse_optional_expression(lexer, TokenKind::RParen)?;
                let body = parse_statement(lexer)?;
                Ok(Statement::For {
                    init,
                    condition,
                    post,
                    body: body.into(),
                    label: None,
                })
            }
            _ => parse_expression(lexer)
                .and_then(|s| {
                    lexer.expect(TokenKind::Semicolon)?;
                    Ok(s)
                })
                .map(Statement::Expression),
        },
        None => Err(ParserError::UnexpectedEOF),
    }
}

fn parse_expression(lexer: &mut Lexer) -> Result<Expression> {
    parse_expression_bp(lexer, 0)
}

fn parse_expression_bp(lexer: &mut Lexer, min_bp: u8) -> Result<Expression> {
    let Some((span, kind)) = lexer.next_token() else {
        return Err(ParserError::UnexpectedEOF);
    };
    let mut lhs = match kind {
        TokenKind::Constant => lexer.source[span.range()]
            .parse()
            .map(Expression::Constant)
            .map_err(|e| ParserError::ConstantOutOfRange { error: e, span }),
        TokenKind::Identifier => Ok(Expression::Var(lexer.source[span.range()].into())),

        TokenKind::LParen => parse_expression_bp(lexer, 0).and_then(|expr| {
            let rparen_span = lexer.expect(TokenKind::RParen)?;
            Ok(Expression::Parenthesized {
                lparen_span: span,
                expr: Box::new(expr),
                rparen_span,
            })
        }),

        // Prefix operators
        TokenKind::Hypen if min_bp <= 60 => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Minus, Box::new(e))),
        TokenKind::Tilde if min_bp <= 60 => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Complement, Box::new(e))),
        TokenKind::Exclamation if min_bp <= 60 => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::Not, Box::new(e))),
        TokenKind::PlusPlus if min_bp <= 60 => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::PrefixIncrement, Box::new(e))),
        TokenKind::MinusMinus if min_bp <= 60 => parse_expression_bp(lexer, 60)
            .map(|e| Expression::Unary(UnaryOperator::PrefixDecrement, Box::new(e))),

        kind => {
            return Err(ParserError::Expected {
                options: vec![],
                kind,
                span,
            });
        }
    }?;

    loop {
        let Some((span, next)) = lexer.tokens.last() else {
            break;
        };
        let (op, r_bp) = match next {
            // Ternary
            TokenKind::Question if min_bp <= 3 => {
                lexer.next_token();
                let then = parse_expression_bp(lexer, 0)?;
                lexer.expect(TokenKind::Colon)?;
                let r#else = parse_expression_bp(lexer, 3)?;
                lhs = Expression::Ternary(Box::new(lhs), Box::new(then), Box::new(r#else));
                continue;
            }
            TokenKind::Equals if min_bp <= 1 => {
                lexer.next_token();
                let rhs = parse_expression_bp(lexer, 1)?;
                lhs = Expression::Assignment(Box::new(lhs), Box::new(rhs));
                continue;
            }
            // Assignment
            TokenKind::PlusEquals
            | TokenKind::MinusEquals
            | TokenKind::TimesEquals
            | TokenKind::DivEquals
            | TokenKind::ModEquals
            | TokenKind::AndEquals
            | TokenKind::OrEquals
            | TokenKind::XorEquals
            | TokenKind::ShiftRightEquals
            | TokenKind::ShiftLeftEquals
                if min_bp <= 1 =>
            {
                let op = match next {
                    TokenKind::PlusEquals => BinaryOperator::Add,
                    TokenKind::MinusEquals => BinaryOperator::Subtract,
                    TokenKind::TimesEquals => BinaryOperator::Multiply,
                    TokenKind::DivEquals => BinaryOperator::Divide,
                    TokenKind::ModEquals => BinaryOperator::Remainder,
                    TokenKind::AndEquals => BinaryOperator::BitwiseAnd,
                    TokenKind::OrEquals => BinaryOperator::BitwiseOr,
                    TokenKind::XorEquals => BinaryOperator::Xor,
                    TokenKind::ShiftRightEquals => BinaryOperator::RightShift,
                    TokenKind::ShiftLeftEquals => BinaryOperator::LeftShift,
                    _ => unreachable!(),
                };
                lexer.next_token();
                let rhs = parse_expression_bp(lexer, 1)?;
                lhs = Expression::CompoundAssignment(Box::new(lhs), op, Box::new(rhs));
                continue;
            }
            // Postfix
            TokenKind::PlusPlus if min_bp <= 65 => {
                lexer.next_token();
                lhs = Expression::Unary(UnaryOperator::PostfixIncrement, Box::new(lhs));
                continue;
            }
            TokenKind::MinusMinus if min_bp <= 65 => {
                lexer.next_token();
                lhs = Expression::Unary(UnaryOperator::PostfixDecrement, Box::new(lhs));
                continue;
            }
            // Binary
            TokenKind::DoublePipe => (BinaryOperator::Or, 5),
            TokenKind::DoubleAnd => (BinaryOperator::And, 10),
            TokenKind::Pipe => (BinaryOperator::BitwiseOr, 25),
            TokenKind::Caret => (BinaryOperator::Xor, 30),
            TokenKind::Ampersand => (BinaryOperator::BitwiseAnd, 35),
            TokenKind::NotEqual => (BinaryOperator::NotEqual, 36),
            TokenKind::DoubleEquals => (BinaryOperator::Equals, 36),
            TokenKind::Less => (BinaryOperator::LessThan, 38),
            TokenKind::LessEqual => (BinaryOperator::LessThanOrEqual, 38),
            TokenKind::Greater => (BinaryOperator::GreaterThan, 38),
            TokenKind::GreaterEqual => (BinaryOperator::GreaterThanOrEqual, 38),
            TokenKind::ShRight => (BinaryOperator::RightShift, 40),
            TokenKind::ShLeft => (BinaryOperator::LeftShift, 40),
            TokenKind::Plus => (BinaryOperator::Add, 45),
            TokenKind::Hypen => (BinaryOperator::Subtract, 45),
            TokenKind::Asterisk => (BinaryOperator::Multiply, 50),
            TokenKind::FSlash => (BinaryOperator::Divide, 50),
            TokenKind::Percent => (BinaryOperator::Remainder, 50),
            // Indexing / Call
            TokenKind::LParen => {
                if !matches!(lhs, Expression::Var(_)) {
                    return Err(ParserError::Expected {
                        options: vec![TokenKind::Identifier],
                        kind: TokenKind::InvalidIdentifier,
                        span: span.clone(),
                    });
                }
                lhs = {
                    lexer.expect(TokenKind::LParen)?;
                    let mut params = vec![];
                    if lexer.peek_kind(TokenKind::RParen) {
                    } else {
                        params.push(parse_expression(lexer)?);
                        while lexer.expect(TokenKind::Comma).is_ok() {
                            params.push(parse_expression(lexer)?);
                        }
                    }
                    lexer.expect(TokenKind::RParen)?;
                    Ok(Expression::FunctionCall(lhs.into(), params))
                }?;
                continue;
            }
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
            declarations: [
                Function(
                    FunctionDeclaration {
                        identifier: "main",
                        params: [],
                        body: Some(
                            Block {
                                items: [
                                    Statement(
                                        Return(
                                            Constant(
                                                2,
                                            ),
                                        ),
                                    ),
                                ],
                            },
                        ),
                    },
                ),
            ],
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
            declarations: [
                Function(
                    FunctionDeclaration {
                        identifier: "main",
                        params: [],
                        body: Some(
                            Block {
                                items: [
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
                        ),
                    },
                ),
            ],
        }
        "#);
        Ok(())
    }
}
