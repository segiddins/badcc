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
    CompoundAssignment(Box<Expression>, BinaryOperator, Box<Expression>),
    Ternary(Box<Expression>, Box<Expression>, Box<Expression>),
}

#[derive(Debug)]
pub enum UnaryOperator {
    Minus,
    Complement,
    Not,
    PrefixIncrement,
    PrefixDecrement,
    PostfixIncrement,
    PostfixDecrement,
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
    If(Expression, Box<Statement>, Option<Box<Statement>>),
    Labeled(String, Box<Statement>),
    Goto(String),
    Compound(Block),
    Null,
}

#[derive(Debug)]
pub struct Block {
    pub items: Vec<BlockItem>,
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
    pub body: Block,
}

struct Lexer<'i> {
    source: &'i str,
    tokens: Vec<Token>,
}

impl Lexer<'_> {
    fn next_token(&mut self) -> Option<Token> {
        self.tokens.pop()
    }
    fn peek_token(&self) -> Option<&Token> {
        self.tokens.last()
    }
    fn peek_n(&self, n: usize) -> Option<&Token> {
        if n > self.tokens.len() {
            return None;
        }
        self.tokens.get(self.tokens.len() - n)
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

    let body = parse_block(lexer)?;

    Ok(Function {
        name: name.to_owned(),
        body,
    })
}

fn parse_block(lexer: &mut Lexer) -> Result<Block> {
    lexer.expect(TokenKind::LBrace)?;
    let mut items = vec![];
    while !matches!(
        lexer.peek_token(),
        Some(Token {
            kind: TokenKind::RBrace,
            ..
        })
    ) {
        items.push(parse_block_item(lexer)?);
    }
    lexer.expect(TokenKind::RBrace)?;
    Ok(Block { items })
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
                if lexer
                    .peek_token()
                    .is_some_and(|t| t.kind == TokenKind::Else)
                {
                    lexer.expect(TokenKind::Else)?;
                    r#else = Some(parse_statement(lexer)?);
                }
                Ok(Statement::If(cond, Box::new(then), r#else.map(Box::new)))
            }
            TokenKind::Identifier if lexer.peek_n(2).map(|t| t.kind) == Some(TokenKind::Colon) => {
                let label = lexer
                    .expect(TokenKind::Identifier)
                    .map(|t| t.source(lexer.source).to_string())?;
                lexer.expect(TokenKind::Colon)?;
                let statement = parse_statement(lexer)?;
                Ok(Statement::Labeled(label, statement.into()))
            }
            TokenKind::Goto => {
                lexer.expect(TokenKind::Goto)?;
                lexer
                    .expect(TokenKind::Identifier)
                    .map(|t| Statement::Goto(t.source(lexer.source).to_string()))
                    .and_then(|s| {
                        lexer.expect(TokenKind::Semicolon)?;
                        Ok(s)
                    })
            }
            TokenKind::LBrace => parse_block(lexer).map(Statement::Compound),
            _ => parse_expression(lexer)
                .and_then(|s| {
                    lexer.expect(TokenKind::Semicolon)?;
                    Ok(s)
                })
                .map(Statement::Expression),
        },
        None => bail!("unexpected EOF"),
    }
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
        TokenKind::Identifier => Ok(Expression::Var(token.source(lexer.source).to_string())),

        TokenKind::LParen => parse_expression_bp(lexer, 0).and_then(|e| {
            lexer.expect(TokenKind::RParen)?;
            Ok(e)
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

        _ => {
            bail!(
                labels = vec![LabeledSpan::at(token.location, "here")],
                "expected expression"
            )
        }
    }?;

    loop {
        let Some(next) = lexer.peek_token() else {
            break;
        };
        let (op, r_bp) = match next.kind {
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
                let op = match next.kind {
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
