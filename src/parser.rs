use std::{borrow::Borrow, num::ParseIntError};

use miette::{NamedSource, SourceSpan};

use crate::{ast::*, lexer::Token, sema::Type};

impl Borrow<dyn miette::Diagnostic + 'static> for Box<ParserError> {
    fn borrow(&self) -> &(dyn miette::Diagnostic + 'static) {
        self.as_ref()
    }
}

#[derive(Debug, thiserror::Error, miette::Diagnostic)]
#[error("Failed to parse")]
enum ParserError {
    #[error("unexpectedly encountered the end of the file")]
    UnexpectedEOF,

    #[error("expected one of {options:?}, found {kind:?}")]
    Expected {
        options: Vec<Token>,
        kind: Token,
        #[label("here")]
        span: SourceSpan,
    },

    #[error("found extra tokens at the end of the program")]
    ExtraToken {
        #[label("here")]
        span: SourceSpan,
    },

    #[error("integer constant is out of range")]
    ConstantOutOfRange {
        #[source]
        error: ParseIntError,

        #[label("here")]
        span: SourceSpan,
    },
    #[error("declaration cannot have more than one storage specifier")]
    MultipleDeclSpecifiers {
        #[label("specifiers")]
        span: SourceSpan,
    },
    #[error("declaration must have exactly one type")]
    DeclSingleType {
        #[label("specifiers")]
        span: SourceSpan,
    },
}

type Result<T> = std::result::Result<T, ParserError>;

fn spanning(start: SourceSpan, end: SourceSpan) -> SourceSpan {
    (start.offset()..(end.offset() + end.len())).into()
}

struct Lexer<'i> {
    source: &'i str,
    tokens: Vec<(Token, SourceSpan)>,
}

impl Lexer<'_> {
    fn mark(&self) -> SourceSpan {
        self.peek_token()
            .map(|t| t.1)
            .unwrap_or_else(|| (self.source.len() - 1, 0).into())
    }

    fn next_token(&mut self) -> Option<(Token, SourceSpan)> {
        self.tokens.pop()
    }
    fn peek_token(&self) -> Option<(Token, SourceSpan)> {
        self.tokens.last().copied()
    }
    fn peek_n(&self, n: usize) -> Option<(Token, SourceSpan)> {
        if n > self.tokens.len() {
            return None;
        }
        self.tokens.get(self.tokens.len() - n).copied()
    }

    fn expect_identifier(&mut self) -> Result<(String, SourceSpan)> {
        if self.tokens.is_empty() {
            return Err(ParserError::UnexpectedEOF);
        }
        self.tokens
            .pop_if(|(t, _)| matches!(t, Token::Identifier))
            .ok_or_else(|| {
                let (token, span) = self.peek_token().unwrap();
                ParserError::Expected {
                    options: vec![Token::Identifier],
                    kind: token,
                    span,
                }
            })
            .map(|(t, span)| match t {
                Token::Identifier => (self.str_at(span).into(), span),
                _ => unreachable!(),
            })
    }

    fn expect(&mut self, kind: Token) -> Result<(Token, SourceSpan)> {
        if self.tokens.is_empty() {
            return Err(ParserError::UnexpectedEOF);
        }
        self.tokens.pop_if(|(t, _)| *t == kind).ok_or_else(|| {
            let (token, span) = self.peek_token().unwrap();
            ParserError::Expected {
                options: vec![kind],
                kind: token,
                span,
            }
        })
    }

    fn peek_kind(&self, kind: Token) -> bool {
        self.peek_token().is_some_and(|(t, _)| t == kind)
    }

    fn peek_decl_specifier(&self) -> bool {
        self.peek_token().is_some_and(|(t, _)| {
            t == Token::Int || t == Token::Static || t == Token::Extern || t == Token::Long
        })
    }

    fn str_at(&self, span: SourceSpan) -> &str {
        &self.source[span.offset()..(span.offset() + span.len())]
    }
}

pub fn parse(
    source: impl AsRef<str>,
    mut tokens: Vec<(Token, SourceSpan)>,
    filename: &str,
) -> miette::Result<Program> {
    tokens.reverse();
    let mut lexer = Lexer {
        source: source.as_ref(),
        tokens,
    };
    parse_program(&mut lexer)
        .and_then(|program| {
            if let Some((_, span)) = lexer.next_token() {
                return Err(ParserError::ExtraToken { span });
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
    Ok(Program { declarations })
}

fn parse_block(lexer: &mut Lexer) -> Result<Block> {
    let (_, start) = lexer.expect(Token::LBrace)?;
    let mut items = vec![];
    while !matches!(lexer.peek_token(), Some((Token::RBrace, _))) {
        items.push(parse_block_item(lexer)?);
    }
    let (_, end) = lexer.expect(Token::RBrace)?;
    let span = spanning(start, end);
    Ok(Block { items, span })
}

fn parse_block_item(lexer: &mut Lexer) -> Result<BlockItem> {
    if lexer.peek_decl_specifier() {
        parse_declaration(lexer).map(BlockItem::Declaration)
    } else {
        parse_statement(lexer).map(BlockItem::Statement)
    }
}

fn parse_decl_specifiers(lexer: &mut Lexer) -> Result<(Option<StorageClass>, Type)> {
    let start = lexer.mark();
    let mut end = start;
    let mut storage = None;
    let mut ty: Vec<Token> = vec![];
    loop {
        match lexer.peek_token() {
            Some((token, span)) => {
                match token {
                    Token::Int | Token::Long => {
                        ty.push(token);
                        lexer.next_token();
                    }
                    Token::Extern => {
                        lexer.next_token();
                        if storage.is_some() {
                            return Err(ParserError::MultipleDeclSpecifiers {
                                span: spanning(start, span),
                            });
                        }
                        storage.replace(StorageClass::Extern);
                    }
                    Token::Static => {
                        lexer.next_token();
                        if storage.is_some() {
                            return Err(ParserError::MultipleDeclSpecifiers {
                                span: spanning(start, span),
                            });
                        }
                        storage.replace(StorageClass::Static);
                    }
                    _ => break,
                }
                end = span;
            }
            None => return Err(ParserError::UnexpectedEOF),
        }
    }

    let ty = match ty {
        _ if ty == [Token::Int] => Type::Int,
        _ if ty == [Token::Long, Token::Int]
            || ty == [Token::Int, Token::Long]
            || ty == [Token::Long] =>
        {
            Type::Long
        }
        _ => {
            return Err(ParserError::DeclSingleType {
                span: spanning(start, end),
            });
        }
    };

    Ok((storage, ty))
}

fn parse_variable_declaration(lexer: &mut Lexer) -> Result<VariableDeclaration> {
    let start = lexer.mark();
    let (storage, ty) = parse_decl_specifiers(lexer)?;
    let (name, _) = lexer.expect_identifier()?;

    let init = if lexer.expect(Token::Equals).is_ok() {
        Some(parse_expression(lexer)?)
    } else {
        None
    };

    let (_, end) = lexer.expect(Token::Semicolon)?;
    let span = spanning(start, end);

    Ok(VariableDeclaration {
        name: name.to_string(),
        ty,
        init,
        storage,
        span,
    })
}

fn parse_type(lexer: &mut Lexer) -> Result<Type> {
    if lexer.expect(Token::Int).is_ok() {
        if lexer.expect(Token::Long).is_ok() {
            Ok(Type::Long)
        } else {
            Ok(Type::Int)
        }
    } else if lexer.expect(Token::Long).is_ok() {
        let _ = lexer.expect(Token::Int);
        Ok(Type::Long)
    } else if let Some((token, span)) = lexer.peek_token() {
        Err(ParserError::Expected {
            options: vec![Token::Int, Token::Long],
            kind: token,
            span,
        })
    } else {
        Err(ParserError::UnexpectedEOF)
    }
}

fn parse_declaration(lexer: &mut Lexer) -> Result<Declaration> {
    let start = lexer.mark();
    for n in 2.. {
        match lexer.peek_n(n) {
            Some((Token::Semicolon | Token::Equals, _)) => {
                return parse_variable_declaration(lexer).map(Declaration::Variable);
            }
            Some((Token::LParen, _)) | None => break,
            _ => {}
        }
    }

    let (storage, ret) = parse_decl_specifiers(lexer)?;
    let (identifier, _) = lexer.expect_identifier()?;

    lexer.expect(Token::LParen)?;

    let mut params = vec![];
    if !(lexer.expect(Token::Void).is_ok() || lexer.peek_kind(Token::RParen)) {
        let ty = parse_type(lexer)?;
        let (id, span) = lexer.expect_identifier()?;
        params.push((ty, id, span));
        while lexer.expect(Token::Comma).is_ok() {
            let ty = parse_type(lexer)?;
            let (id, span) = lexer.expect_identifier()?;
            params.push((ty, id, span));
        }
    }

    lexer.expect(Token::RParen)?;

    let (body, end) = if lexer.peek_kind(Token::LBrace) {
        let block = parse_block(lexer)?;
        let span = block.span;
        (Some(block), span)
    } else {
        let (_, span) = lexer.expect(Token::Semicolon)?;
        (None, span)
    };
    let span = spanning(start, end);
    Ok(Declaration::Function(FunctionDeclaration {
        identifier,
        params,
        ret,
        body,
        storage,
        span,
    }))
}

fn parse_optional_expression(lexer: &mut Lexer, end: Token) -> Result<Option<Expression>> {
    if lexer.expect(end).is_ok() {
        return Ok(None);
    }

    let expression = parse_expression(lexer)?;
    lexer.expect(end)?;
    Ok(Some(expression))
}

fn parse_for_init(lexer: &mut Lexer) -> Result<ForInit> {
    if lexer.peek_decl_specifier() {
        parse_variable_declaration(lexer).map(ForInit::Decl)
    } else {
        parse_optional_expression(lexer, Token::Semicolon).map(ForInit::Expr)
    }
}

fn parse_statement(lexer: &mut Lexer) -> Result<Statement> {
    match lexer.peek_token() {
        Some((token, _span)) => match token {
            Token::Return => lexer
                .expect(Token::Return)
                .and_then(|_| Ok(Statement::Return(parse_expression(lexer)?)))
                .and_then(|s| {
                    lexer.expect(Token::Semicolon)?;
                    Ok(s)
                }),
            Token::Semicolon => lexer.expect(Token::Semicolon).map(|_| Statement::Null),
            Token::If => {
                lexer.expect(Token::If)?;
                lexer.expect(Token::LParen)?;
                let cond = parse_expression(lexer)?;
                lexer.expect(Token::RParen)?;
                let then = parse_statement(lexer)?;
                let mut r#else = None;
                if lexer.expect(Token::Else).is_ok() {
                    r#else = Some(parse_statement(lexer)?);
                }
                Ok(Statement::If {
                    cond,
                    if_true: Box::new(then),
                    if_false: r#else.map(Box::new),
                })
            }
            Token::Identifier if lexer.peek_n(2).is_some_and(|(t, _)| t == Token::Colon) => {
                let (label, span) = lexer.expect_identifier()?;
                lexer.expect(Token::Colon)?;
                let statement = parse_statement(lexer)?;
                Ok(Statement::Labeled {
                    label,
                    statement: statement.into(),
                    span,
                })
            }
            Token::Goto => {
                lexer.expect(Token::Goto)?;
                lexer
                    .expect_identifier()
                    .map(|(t, _)| Statement::Goto {
                        label: t.clone(),
                        span: _span,
                    })
                    .and_then(|s| {
                        lexer.expect(Token::Semicolon)?;
                        Ok(s)
                    })
            }
            Token::Switch => {
                lexer.next_token();
                lexer.expect(Token::LParen)?;
                let expr = parse_expression(lexer)?;
                lexer.expect(Token::RParen)?;

                Ok(Statement::Switch {
                    condition: expr,
                    body: parse_statement(lexer)?.into(),
                    label: None,
                })
            }
            Token::LBrace => parse_block(lexer).map(Statement::Compound),
            Token::Case => {
                lexer.next_token();
                let expr = parse_expression(lexer)?;
                lexer.expect(Token::Colon)?;
                Ok(Statement::Case {
                    expression: expr,
                    statement: parse_statement(lexer)?.into(),
                    label: None,
                })
            }
            Token::Default => {
                lexer.next_token();
                lexer.expect(Token::Colon)?;
                Ok(Statement::Default {
                    statement: parse_statement(lexer)?.into(),
                    label: None,
                    span: _span,
                })
            }
            Token::Break => {
                lexer.next_token();
                lexer.expect(Token::Semicolon)?;
                Ok(Statement::Break {
                    label: None,
                    span: _span,
                })
            }
            Token::Continue => {
                lexer.next_token();
                lexer.expect(Token::Semicolon)?;
                Ok(Statement::Continue {
                    label: None,
                    span: _span,
                })
            }
            Token::While => {
                lexer.next_token();
                lexer.expect(Token::LParen)?;
                let exp = parse_expression(lexer)?;
                lexer.expect(Token::RParen)?;
                parse_statement(lexer).map(|s| Statement::While {
                    expression: exp,
                    statement: s.into(),
                    label: None,
                })
            }
            Token::Do => {
                lexer.next_token();
                let body = parse_statement(lexer)?;
                lexer.expect(Token::While)?;
                lexer.expect(Token::LParen)?;
                let cond = parse_expression(lexer)?;
                lexer.expect(Token::RParen)?;
                lexer.expect(Token::Semicolon)?;
                Ok(Statement::DoWhile {
                    statement: body.into(),
                    expression: cond,
                    label: None,
                })
            }
            Token::For => {
                lexer.next_token();
                lexer.expect(Token::LParen)?;
                let init = parse_for_init(lexer)?;
                let condition = parse_optional_expression(lexer, Token::Semicolon)?;
                let post = parse_optional_expression(lexer, Token::RParen)?;
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
                    lexer.expect(Token::Semicolon)?;
                    Ok(s)
                })
                .map(Statement::Expression),
        },
        None => Err(ParserError::UnexpectedEOF),
    }
}

fn parse_expression(lexer: &mut Lexer) -> Result<Expression> {
    parse_expression_bp(
        lexer,
        0,
        lexer.peek_token().map_or((0, 0).into(), |(_, span)| span),
    )
    .map(|(e, _)| e)
}

fn parse_expression_bp(
    lexer: &mut Lexer,
    min_bp: u8,
    start: SourceSpan,
) -> Result<(Expression, SourceSpan)> {
    let Some((token, span)) = lexer.next_token() else {
        return Err(ParserError::UnexpectedEOF);
    };
    let mut lhs = match token {
        Token::Constant => {
            let s = lexer.str_at(span);
            if let Some(s) = lexer.source[span.offset()..(span.offset() + span.len())]
                .strip_suffix(|c| c == 'l' || c == 'L')
            {
                s.parse().map(Constant::Long)
            } else {
                s.parse()
                    .map(Constant::Int)
                    .or_else(|_| s.parse().map(Constant::Long))
            }
            .map(|constant| Expression::Constant { constant, span })
            .map_err(|error| ParserError::ConstantOutOfRange { error, span })
        }
        Token::Identifier => Ok(Expression::Var {
            name: lexer.str_at(span).into(),
            span,
        }),

        Token::LParen => {
            if let Ok(to) = parse_type(lexer) {
                lexer.expect(Token::RParen)?;
                let (exp, span) = parse_expression_bp(lexer, 65, span)?;
                Ok(Expression::Cast {
                    to,
                    expr: exp.into(),
                    span,
                })
            } else {
                parse_expression_bp(lexer, 0, span).and_then(|(e, _)| {
                    lexer.expect(Token::RParen)?;
                    Ok(e)
                })
            }
        }

        // Prefix operators
        Token::Hypen if min_bp <= 60 => {
            parse_expression_bp(lexer, 60, span).map(|(e, span)| Expression::Unary {
                op: UnaryOperator::Minus,
                expr: Box::new(e),
                span,
            })
        }
        Token::Tilde if min_bp <= 60 => {
            parse_expression_bp(lexer, 60, span).map(|(e, span)| Expression::Unary {
                op: UnaryOperator::Complement,
                expr: Box::new(e),
                span,
            })
        }
        Token::Exclamation if min_bp <= 60 => {
            parse_expression_bp(lexer, 60, span).map(|(e, span)| Expression::Unary {
                op: UnaryOperator::Not,
                expr: Box::new(e),
                span,
            })
        }
        Token::PlusPlus if min_bp <= 60 => {
            parse_expression_bp(lexer, 60, span).map(|(e, span)| Expression::Unary {
                op: UnaryOperator::PrefixIncrement,
                expr: Box::new(e),
                span,
            })
        }
        Token::MinusMinus if min_bp <= 60 => {
            parse_expression_bp(lexer, 60, span).map(|(e, span)| Expression::Unary {
                op: UnaryOperator::PrefixDecrement,
                expr: Box::new(e),
                span,
            })
        }

        kind => {
            return Err(ParserError::Expected {
                options: vec![
                    Token::Constant,
                    Token::Identifier,
                    Token::LParen,
                    Token::Hypen,
                    Token::Tilde,
                    Token::Exclamation,
                    Token::PlusPlus,
                    Token::MinusMinus,
                ],
                kind,
                span,
            });
        }
    }?;

    loop {
        let Some((next, next_span)) = lexer.peek_token() else {
            break;
        };
        let (op, r_bp) = match next {
            // Ternary
            Token::Question if min_bp <= 3 => {
                lexer.next_token();
                let (then, span) = parse_expression_bp(lexer, 0, span)?;
                lexer.expect(Token::Colon)?;
                let (r#else, span) = parse_expression_bp(lexer, 3, span)?;
                lhs = Expression::Ternary {
                    cond: Box::new(lhs),
                    if_true: Box::new(then),
                    if_false: Box::new(r#else),
                    span,
                };
                continue;
            }
            Token::Equals if min_bp <= 1 => {
                lexer.next_token();
                let (rhs, span) = parse_expression_bp(lexer, 1, span)?;
                lhs = Expression::Assignment {
                    lhs: Box::new(lhs),
                    rhs: Box::new(rhs),
                    span,
                };
                continue;
            }
            // Assignment
            Token::PlusEquals
            | Token::MinusEquals
            | Token::TimesEquals
            | Token::DivEquals
            | Token::ModEquals
            | Token::AndEquals
            | Token::OrEquals
            | Token::XorEquals
            | Token::ShiftRightEquals
            | Token::ShiftLeftEquals
                if min_bp <= 1 =>
            {
                let op = match next {
                    Token::PlusEquals => BinaryOperator::Add,
                    Token::MinusEquals => BinaryOperator::Subtract,
                    Token::TimesEquals => BinaryOperator::Multiply,
                    Token::DivEquals => BinaryOperator::Divide,
                    Token::ModEquals => BinaryOperator::Remainder,
                    Token::AndEquals => BinaryOperator::BitwiseAnd,
                    Token::OrEquals => BinaryOperator::BitwiseOr,
                    Token::XorEquals => BinaryOperator::Xor,
                    Token::ShiftRightEquals => BinaryOperator::RightShift,
                    Token::ShiftLeftEquals => BinaryOperator::LeftShift,
                    _ => unreachable!(),
                };
                lexer.next_token();
                let (rhs, span) = parse_expression_bp(lexer, 1, span)?;
                lhs = Expression::CompoundAssignment {
                    op,
                    lhs: Box::new(lhs),
                    rhs: Box::new(rhs),
                    span,
                };
                continue;
            }
            // Postfix
            Token::PlusPlus if min_bp <= 65 => {
                let (_, end) = lexer.next_token().unwrap();
                lhs = Expression::Unary {
                    op: UnaryOperator::PostfixIncrement,
                    expr: Box::new(lhs),
                    span: spanning(span, end),
                };
                continue;
            }
            Token::MinusMinus if min_bp <= 65 => {
                let (_, end) = lexer.next_token().unwrap();
                lhs = Expression::Unary {
                    op: UnaryOperator::PostfixDecrement,
                    expr: Box::new(lhs),
                    span: spanning(span, end),
                };
                continue;
            }
            // Binary
            Token::DoublePipe => (BinaryOperator::Or, 5),
            Token::DoubleAnd => (BinaryOperator::And, 10),
            Token::Pipe => (BinaryOperator::BitwiseOr, 25),
            Token::Caret => (BinaryOperator::Xor, 30),
            Token::Ampersand => (BinaryOperator::BitwiseAnd, 35),
            Token::NotEqual => (BinaryOperator::NotEqual, 36),
            Token::DoubleEquals => (BinaryOperator::Equals, 36),
            Token::Less => (BinaryOperator::LessThan, 38),
            Token::LessEqual => (BinaryOperator::LessThanOrEqual, 38),
            Token::Greater => (BinaryOperator::GreaterThan, 38),
            Token::GreaterEqual => (BinaryOperator::GreaterThanOrEqual, 38),
            Token::ShRight => (BinaryOperator::RightShift, 40),
            Token::ShLeft => (BinaryOperator::LeftShift, 40),
            Token::Plus => (BinaryOperator::Add, 45),
            Token::Hypen => (BinaryOperator::Subtract, 45),
            Token::Asterisk => (BinaryOperator::Multiply, 50),
            Token::FSlash => (BinaryOperator::Divide, 50),
            Token::Percent => (BinaryOperator::Remainder, 50),
            // Indexing / Call
            Token::LParen => {
                if !matches!(lhs, Expression::Var { .. }) {
                    return Err(ParserError::Expected {
                        options: vec![Token::Identifier],
                        kind: Token::InvalidIdentifier,
                        span: next_span,
                    });
                }
                lhs = {
                    lexer.expect(Token::LParen)?;
                    let mut params = vec![];
                    if lexer.peek_kind(Token::RParen) {
                    } else {
                        params.push(parse_expression(lexer)?);
                        while lexer.expect(Token::Comma).is_ok() {
                            params.push(parse_expression(lexer)?);
                        }
                    }
                    let (_, end) = lexer.expect(Token::RParen)?;
                    Ok(Expression::FunctionCall {
                        function: lhs.into(),
                        params,
                        span: spanning(span, end),
                    })
                }?;
                continue;
            }
            _ => break,
        };
        if r_bp < min_bp {
            break;
        }
        lexer.next_token();
        let (rhs, span) = parse_expression_bp(lexer, r_bp + 1, span)?;
        lhs = Expression::Binary {
            op,
            lhs: Box::new(lhs),
            rhs: Box::new(rhs),
            span,
        };
    }
    let span = spanning(start, lhs.span());
    Ok((lhs, span))
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
                FunctionDeclaration {
                    identifier: "main",
                    params: [],
                    ret: Int,
                    body: [
                        Return(
                            Constant {
                                constant: 2,
                            },
                        ),
                    ],
                },
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
                FunctionDeclaration {
                    identifier: "main",
                    params: [],
                    ret: Int,
                    body: [
                        Expression(
                            Binary {
                                op: Add,
                                lhs: Constant {
                                    constant: 1,
                                },
                                rhs: Constant {
                                    constant: 1,
                                },
                            },
                        ),
                        Null,
                        Null,
                        Return(
                            Constant {
                                constant: 2,
                            },
                        ),
                    ],
                },
            ],
        }
        "#);
        Ok(())
    }
}
