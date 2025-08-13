use miette::NamedSource;

use crate::located::Span;

#[derive(Debug)]
pub struct Program {
    pub declarations: Vec<Declaration>,
    pub file_name: String,
    pub contents: String,
}

impl Program {
    fn source_code(&self) -> NamedSource<String> {
        NamedSource::new(self.file_name.as_str(), self.contents.clone()).with_language("c")
    }
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
    FunctionCall(Box<Expression>, Vec<Expression>),
    Parenthesized {
        lparen_span: Span,
        expr: Box<Expression>,
        rparen_span: Span,
    },
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
    Break(Option<String>),
    Continue(Option<String>),
    While(Expression, Box<Statement>, Option<String>),
    DoWhile(Box<Statement>, Expression, Option<String>),
    For {
        init: ForInit,
        condition: Option<Expression>,
        post: Option<Expression>,
        body: Box<Statement>,
        label: Option<String>,
    },
    Switch(Expression, Box<Statement>, Option<String>),
    Case(Expression, Box<Statement>, Option<String>),
    Default(Box<Statement>, Option<String>),
    Null,
}

#[derive(Debug)]
pub struct Block {
    pub items: Vec<BlockItem>,
}

#[derive(Debug)]
pub enum ForInit {
    Decl(VariableDeclaration),
    Expr(Option<Expression>),
}

#[derive(Debug)]
pub enum Declaration {
    Variable(VariableDeclaration),
    Function(FunctionDeclaration),
}

#[derive(Debug)]
pub struct FunctionDeclaration {
    pub identifier: String,
    pub params: Vec<String>,
    pub body: Option<Block>,
}

#[derive(Debug)]
pub struct VariableDeclaration {
    pub name: String,
    pub init: Option<Expression>,
}

#[derive(Debug)]
pub enum BlockItem {
    Statement(Statement),
    Declaration(Declaration),
}
