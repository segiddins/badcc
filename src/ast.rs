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

pub trait Spanned {
    fn span(&self) -> SourceSpan;
}

impl Spanned for SourceSpan {
    fn span(&self) -> SourceSpan {
        *self
    }
}

#[derive(Debug)]
pub struct Program {
    pub declarations: Vec<Declaration>,
}

#[derive(Clone)]
pub enum Expression {
    Constant {
        constant: Constant,
        span: SourceSpan,
    },
    Unary {
        op: UnaryOperator,
        expr: Box<Expression>,
        span: SourceSpan,
    },
    Binary {
        op: BinaryOperator,
        lhs: Box<Expression>,
        rhs: Box<Expression>,
        span: SourceSpan,
    },
    Var {
        name: String,
        span: SourceSpan,
    },
    Assignment {
        lhs: Box<Expression>,
        rhs: Box<Expression>,
        span: SourceSpan,
    },
    CompoundAssignment {
        op: BinaryOperator,
        lhs: Box<Expression>,
        rhs: Box<Expression>,
        span: SourceSpan,
    },
    Ternary {
        cond: Box<Expression>,
        if_true: Box<Expression>,
        if_false: Box<Expression>,
        span: SourceSpan,
    },
    FunctionCall {
        function: Box<Expression>,
        params: Vec<Expression>,
        span: SourceSpan,
    },
    Cast {
        to: Type,
        expr: Box<Expression>,
        span: SourceSpan,
    },
}

impl Default for Expression {
    fn default() -> Self {
        Self::Constant {
            constant: Constant::Int(0),
            span: SourceSpan::new(0.into(), 0),
        }
    }
}

impl Spanned for Expression {
    fn span(&self) -> SourceSpan {
        match self {
            Expression::Constant { span, .. }
            | Expression::Unary { span, .. }
            | Expression::Binary { span, .. }
            | Expression::Var { span, .. }
            | Expression::Assignment { span, .. }
            | Expression::CompoundAssignment { span, .. }
            | Expression::Ternary { span, .. }
            | Expression::FunctionCall { span, .. }
            | Expression::Cast { span, .. } => *span,
        }
    }
}

impl Debug for Expression {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Constant { constant, span: _ } => write!(f, "Constant({constant:?})"),
            Self::Unary { op, expr, span: _ } => f
                .debug_struct("Unary")
                .field("op", op)
                .field("expr", expr)
                .finish(),
            Self::Binary {
                op,
                lhs,
                rhs,
                span: _,
            } => f
                .debug_struct("Binary")
                .field("op", op)
                .field("lhs", lhs)
                .field("rhs", rhs)
                .finish(),
            Self::Var { name, span: _ } => write!(f, "Var({name:?})"),
            Self::Assignment { lhs, rhs, span: _ } => f
                .debug_struct("Assignment")
                .field("lhs", lhs)
                .field("rhs", rhs)
                .finish(),
            Self::CompoundAssignment {
                op,
                lhs,
                rhs,
                span: _,
            } => f
                .debug_struct("CompoundAssignment")
                .field("op", op)
                .field("lhs", lhs)
                .field("rhs", rhs)
                .finish(),
            Self::Ternary {
                cond,
                if_true,
                if_false,
                span: _,
            } => f
                .debug_struct("Ternary")
                .field("cond", cond)
                .field("if_true", if_true)
                .field("if_false", if_false)
                .finish(),
            Self::FunctionCall {
                function,
                params,
                span: _,
            } => f
                .debug_struct("FunctionCall")
                .field("function", function)
                .field_if("params", params, !params.is_empty())
                .finish(),
            Self::Cast { to, expr, span: _ } => f
                .debug_struct("Cast")
                .field("to", to)
                .field("expr", expr)
                .finish(),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
pub enum Constant {
    Int(i32),
    Long(i64),
    UInt(u32),
    ULong(u64),
}

impl Constant {
    pub fn as_long(&self) -> i64 {
        match self {
            Constant::Int(v) => *v as i64,
            Constant::Long(v) => *v,
            Constant::UInt(v) => *v as i64,
            Constant::ULong(v) => *v as i64,
        }
    }

    pub const fn ty(&self) -> Type {
        match self {
            Constant::Int(_) => Type::Int,
            Constant::Long(_) => Type::Long,
            Constant::UInt(_) => Type::UInt,
            Constant::ULong(_) => Type::ULong,
        }
    }
}

impl Debug for Constant {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Int(arg0) => write!(f, "{arg0}"),
            Self::Long(arg0) => write!(f, "{arg0}l"),
            Self::UInt(arg0) => write!(f, "{arg0}u"),
            Self::ULong(arg0) => write!(f, "{arg0}ul"),
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

#[derive()]
pub enum Statement {
    Return(Expression),
    Expression(Expression),
    If {
        cond: Expression,
        if_true: Box<Statement>,
        if_false: Option<Box<Statement>>,
    },
    Labeled {
        label: String,
        statement: Box<Statement>,
        span: SourceSpan,
    },
    Goto {
        label: String,
        span: SourceSpan,
    },
    Compound(Block),
    Break {
        label: Option<String>,
        span: SourceSpan,
    },
    Continue {
        label: Option<String>,
        span: SourceSpan,
    },
    While {
        expression: Expression,
        statement: Box<Statement>,
        label: Option<String>,
    },
    DoWhile {
        statement: Box<Statement>,
        expression: Expression,
        label: Option<String>,
    },
    For {
        init: ForInit,
        condition: Option<Expression>,
        post: Option<Expression>,
        body: Box<Statement>,
        label: Option<String>,
    },
    Switch {
        condition: Expression,
        body: Box<Statement>,
        label: Option<String>,
    },
    Case {
        expression: Expression,
        statement: Box<Statement>,
        label: Option<String>,
    },
    Default {
        statement: Box<Statement>,
        label: Option<String>,
        span: SourceSpan,
    },
    Null,
}

impl Debug for Statement {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Return(arg0) => f.debug_tuple("Return").field(arg0).finish(),
            Self::Expression(arg0) => f.debug_tuple("Expression").field(arg0).finish(),
            Self::If {
                cond: arg0,
                if_true: arg1,
                if_false: arg2,
            } => f
                .debug_tuple("If")
                .field(arg0)
                .field(arg1)
                .field(arg2)
                .finish(),
            Self::Labeled {
                label: arg0,
                statement: arg1,
                span: _,
            } => f.debug_tuple("Labeled").field(arg0).field(arg1).finish(),
            Self::Goto { label, span: _ } => write!(f, "Goto({label:?})"),
            Self::Compound(arg0) => f.debug_tuple("Compound").field(arg0).finish(),
            Self::Break { label, span: _ } => f
                .debug_struct("Break")
                .field_if_set("label", label)
                .finish(),
            Self::Continue { label, span: _ } => f
                .debug_struct("Continue")
                .field_if_set("label", label)
                .finish(),
            Self::While {
                expression: arg0,
                statement: arg1,
                label: arg2,
            } => f
                .debug_tuple("While")
                .field(arg0)
                .field(arg1)
                .field(arg2)
                .finish(),
            Self::DoWhile {
                statement: arg0,
                expression: arg1,
                label: arg2,
            } => f
                .debug_tuple("DoWhile")
                .field(arg0)
                .field(arg1)
                .field(arg2)
                .finish(),
            Self::For {
                init,
                condition,
                post,
                body,
                label,
            } => f
                .debug_struct("For")
                .field("init", init)
                .field_if_set("condition", condition)
                .field_if_set("post", post)
                .field("body", body)
                .field_if_set("label", label)
                .finish(),
            Self::Switch {
                condition: arg0,
                body: arg1,
                label: arg2,
            } => f
                .debug_tuple("Switch")
                .field(arg0)
                .field(arg1)
                .field(arg2)
                .finish(),
            Self::Case {
                expression,
                statement,
                label,
            } => f
                .debug_struct("Case")
                .field("expression", expression)
                .field("statement", statement)
                .field_if_set("label", label)
                .finish(),
            Self::Default {
                statement,
                label,
                span: _,
            } => f
                .debug_struct("Default")
                .field("statement", statement)
                .field_if_set("label", label)
                .finish(),
            Self::Null => write!(f, "Null"),
        }
    }
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

impl Spanned for ForInit {
    fn span(&self) -> SourceSpan {
        match self {
            ForInit::Decl(variable_declaration) => variable_declaration.span,
            ForInit::Expr(expression) => expression.as_ref().map(|e| e.span()).unwrap(),
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

impl Spanned for Declaration {
    fn span(&self) -> SourceSpan {
        match self {
            Declaration::Variable(variable_declaration) => variable_declaration.span,
            Declaration::Function(function_declaration) => function_declaration.span,
        }
    }
}

#[derive()]
pub struct FunctionDeclaration {
    pub identifier: String,
    pub params: Vec<(Type, String, SourceSpan)>,
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
