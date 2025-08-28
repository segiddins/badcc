use miette::SourceSpan;

use crate::sema::Type;

#[derive(Debug)]
pub struct Program {
    pub declarations: Vec<Declaration>,
}

#[derive(Debug, Clone)]
pub enum Expression {
    Constant(Constant),
    Unary(UnaryOperator, Box<Expression>),
    Binary(BinaryOperator, Box<Expression>, Box<Expression>),
    Var(String),
    Assignment(Box<Expression>, Box<Expression>),
    CompoundAssignment(Box<Expression>, BinaryOperator, Box<Expression>),
    Ternary(Box<Expression>, Box<Expression>, Box<Expression>),
    FunctionCall(Box<Expression>, Vec<Expression>),
    Cast(Type, Box<Expression>),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Constant {
    Int(i32),
    Long(i64),
}

impl Constant {
    pub fn into_long(self) -> i64 {
        match self {
            Constant::Int(v) => v as i64,
            Constant::Long(v) => v,
        }
    }

    pub const fn ty(&self) -> Type {
        match self {
            Constant::Int(_) => Type::Int,
            Constant::Long(_) => Type::Long,
        }
    }
}

#[derive(Debug, Clone, Copy)]
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
    pub span: SourceSpan,
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
    pub params: Vec<(Type, String)>,
    pub ret: Type,
    pub body: Option<Block>,
    pub storage: Option<StorageClass>,
    pub span: SourceSpan,
}

#[derive(Debug)]
pub struct VariableDeclaration {
    pub ty: Type,
    pub name: String,
    pub init: Option<Expression>,
    pub storage: Option<StorageClass>,
    pub span: SourceSpan,
}

#[derive(Debug)]
pub enum BlockItem {
    Statement(Statement),
    Declaration(Declaration),
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum StorageClass {
    Static,
    Extern,
}
