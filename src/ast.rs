use std::fmt::{Debug, DebugStruct};

use miette::SourceSpan;

use crate::sema::Type;

trait FieldIf {
    fn field_if(&mut self, name: impl AsRef<str>, value: &dyn Debug, r#if: bool) -> &mut Self;
    fn field_if_set<T: Debug>(&mut self, name: impl AsRef<str>, value: &Option<T>) -> &mut Self {
        match value {
            Some(v) => self.field_if(name, v, true),
            None => self.field_if(name, value, false),
        }
    }
}

impl FieldIf for DebugStruct<'_, '_> {
    fn field_if(&mut self, name: impl AsRef<str>, value: &dyn Debug, r#if: bool) -> &mut Self {
        if r#if {
            self.field(name.as_ref(), value)
        } else {
            self
        }
    }
}

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

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
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

impl Debug for Constant {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Int(arg0) => write!(f, "{arg0}"),
            Self::Long(arg0) => write!(f, "{arg0}l"),
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

#[derive()]
pub struct Block {
    pub items: Vec<BlockItem>,
    pub span: SourceSpan,
}

impl Debug for Block {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        self.items.fmt(f)
    }
}

#[derive()]
pub enum ForInit {
    Decl(VariableDeclaration),
    Expr(Option<Expression>),
}

impl Debug for ForInit {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Decl(arg0) => arg0.fmt(f),
            Self::Expr(arg0) => arg0.fmt(f),
        }
    }
}

#[derive()]
pub enum Declaration {
    Variable(VariableDeclaration),
    Function(FunctionDeclaration),
}

impl Debug for Declaration {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Variable(arg0) => arg0.fmt(f),
            Self::Function(arg0) => arg0.fmt(f),
        }
    }
}

#[derive()]
pub struct FunctionDeclaration {
    pub identifier: String,
    pub params: Vec<(Type, String)>,
    pub ret: Type,
    pub body: Option<Block>,
    pub storage: Option<StorageClass>,
    pub span: SourceSpan,
}

impl Debug for FunctionDeclaration {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let Self {
            identifier,
            params,
            ret,
            body,
            storage,
            span: _,
        } = self;
        f.debug_struct("FunctionDeclaration")
            .field("identifier", identifier)
            .field("params", params)
            .field("ret", ret)
            .field_if_set("body", body)
            .field_if_set("storage", storage)
            .finish()
    }
}

#[derive()]
pub struct VariableDeclaration {
    pub name: String,
    pub ty: Type,
    pub init: Option<Expression>,
    pub storage: Option<StorageClass>,
    pub span: SourceSpan,
}

impl Debug for VariableDeclaration {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let Self {
            ty,
            name,
            init,
            storage,
            span: _,
        } = self;
        f.debug_struct("VariableDeclaration")
            .field("name", name)
            .field("ty", ty)
            .field_if_set("init", init)
            .field_if_set("storage", storage)
            .finish()
    }
}

#[derive()]
pub enum BlockItem {
    Statement(Statement),
    Declaration(Declaration),
}

impl Debug for BlockItem {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Statement(arg0) => arg0.fmt(f),
            Self::Declaration(arg0) => arg0.fmt(f),
        }
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum StorageClass {
    Static,
    Extern,
}
