use std::{
    collections::{BTreeMap, HashMap},
    fmt::Debug,
};

pub use crate::ast::BinaryOperator;
use crate::{
    assembly_gen::Width,
    ast::{
        self, Block, BlockItem, Constant, Declaration, Expression, Statement, VariableDeclaration,
    },
    sema::{self, SymbolAttributes, SymbolTable, Type},
};

#[derive(Debug, Default)]
pub struct Program {
    pub static_variables: Vec<StaticVariable>,
    pub functions: Vec<Function>,
}

#[derive(Debug)]
pub struct Function {
    pub identifier: String,
    pub global: bool,
    pub params: Vec<Val>,
    pub instructions: Vec<Instruction>,
}
#[derive(Debug)]
pub struct StaticVariable {
    pub identifier: String,
    pub global: bool,
    pub init: i64,
    pub width: Width,
}

#[derive(Debug)]
pub enum Instruction {
    Return(Val),
    Unary {
        op: UnaryOperator,
        src: Val,
        dst: Val,
    },
    Binary {
        op: BinaryOperator,
        lhs: Val,
        rhs: Val,
        dst: Val,
    },
    Copy {
        src: Val,
        dst: Val,
    },
    Jump(String),
    JumpIfZero(Val, String),
    JumpIfNotZero(Val, String),
    Label(String),
    Call(String, Vec<Val>, Val),
    SignExtend {
        src: Val,
        dst: Val,
    },
    Truncate {
        src: Val,
        dst: Val,
    },
    ZeroExtend {
        src: Val,
        dst: Val,
    },
}

#[derive(Clone, PartialEq, Eq, Hash)]
pub enum Val {
    Constant(Constant),
    Var(String, Type),
}

impl Debug for Val {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Constant(arg0) => arg0.fmt(f),
            Self::Var(arg0, arg1) => write!(f, "Var({arg0:?}, {arg1:?})"),
        }
    }
}

impl Val {
    pub fn ty(&self) -> Type {
        match self {
            Val::Constant(constant) => constant.ty(),
            Val::Var(_, ty) => ty.clone(),
        }
    }
}

#[derive(Debug)]
pub enum UnaryOperator {
    Complement,
    Negate,
    Not,
}

struct State<'i> {
    temps: u32,
    instructions: Vec<Instruction>,
    phis: u32,
    name: &'i str,
    switch_cases: HashMap<String, Vec<Option<i64>>>,
    symbols: &'i SymbolTable,
    static_variables: BTreeMap<String, StaticVariable>,
}
impl<'i> State<'i> {
    fn var(&mut self, ty: Type) -> Val {
        let v = Val::Var(format!("{}.tmp.{}", self.name, self.temps), ty);
        self.temps += 1;
        v
    }
    fn push(&mut self, instruction: Instruction) {
        self.instructions.push(instruction);
    }

    fn new(name: &'i str, symbols: &'i SymbolTable) -> Self {
        Self {
            temps: 0,
            instructions: vec![],
            phis: 0,
            name,
            switch_cases: Default::default(),
            symbols,
            static_variables: Default::default(),
        }
    }

    fn function(&mut self, name: &'i str) -> Self {
        Self {
            temps: 0,
            instructions: vec![],
            phis: 0,
            name,
            switch_cases: Default::default(),
            symbols: self.symbols,
            static_variables: Default::default(),
        }
    }
}

pub fn lower(program: &ast::Program, symbols: &sema::SymbolTable) -> Program {
    let mut state = State::new("global", symbols);
    let mut functions = vec![];
    for decl in program.declarations.iter() {
        match decl {
            Declaration::Variable(var) => {
                lower_variable_declaration(var, &mut state);
            }
            Declaration::Function(function) => {
                if let Some(function) = lower_function(function, &mut state) {
                    functions.push(function);
                }
            }
        }
    }
    Program {
        static_variables: state.static_variables.into_values().collect(),
        functions,
    }
}

fn constant(ty: Type, value: i64) -> Val {
    match ty {
        Type::Function { .. } => unreachable!(),
        Type::Int => Val::Constant(Constant::Int(value as i32)),
        Type::Long => Val::Constant(Constant::Long(value)),
        Type::UInt => Val::Constant(Constant::UInt(value as u32)),
        Type::ULong => Val::Constant(Constant::ULong(value as u64)),
    }
}

fn lower_variable_declaration<'i>(decl: &VariableDeclaration, state: &mut State<'i>) {
    let symbol = &state.symbols[&decl.name];
    match symbol.attributes {
        SymbolAttributes::Function { .. } => unreachable!(),
        SymbolAttributes::Static {
            init, global: true, ..
        } if init.tentative() => {}
        SymbolAttributes::Static { init, global, .. } => {
            state
                .static_variables
                .entry(decl.name.clone())
                .or_insert_with(|| StaticVariable {
                    identifier: decl.name.clone(),
                    global,
                    init: init.value(),
                    width: decl.ty.width(),
                });
        }
        SymbolAttributes::Local => {
            let var = Val::Var(
                decl.name.clone(),
                state.symbols.get(&decl.name).unwrap().ty.clone(),
            );
            if let Some(rhs) = walk_optional(&decl.init, state) {
                state.push(Instruction::Copy { src: rhs, dst: var })
            }
        }
    }
}

fn walk<'i>(expr: &Expression, state: &mut State<'i>) -> Val {
    match expr {
        Expression::Constant { constant, .. } => Val::Constant(*constant),
        Expression::Unary { op, expr, .. } => {
            let src = walk(expr, state);
            match op {
                ast::UnaryOperator::Minus => {
                    let dst = state.var(src.ty());
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Negate,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                ast::UnaryOperator::Complement => {
                    let dst = state.var(src.ty());
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Complement,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                ast::UnaryOperator::Not => {
                    let dst = state.var(src.ty());
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Not,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                ast::UnaryOperator::PrefixIncrement => {
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: constant(src.ty(), 1),
                        dst: src.clone(),
                    });
                    src
                }
                ast::UnaryOperator::PrefixDecrement => {
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: constant(src.ty(), -1),
                        dst: src.clone(),
                    });
                    src.clone()
                }
                ast::UnaryOperator::PostfixIncrement => {
                    let dst = state.var(src.ty());
                    state.push(Instruction::Copy {
                        src: src.clone(),
                        dst: dst.clone(),
                    });
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: constant(src.ty(), 1),
                        dst: src.clone(),
                    });
                    dst
                }
                ast::UnaryOperator::PostfixDecrement => {
                    let dst = state.var(src.ty());
                    state.push(Instruction::Copy {
                        src: src.clone(),
                        dst: dst.clone(),
                    });
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: constant(src.ty(), -1),
                        dst: src.clone(),
                    });
                    dst
                }
            }
        }
        Expression::Binary {
            op: BinaryOperator::And,
            lhs,
            rhs,
            ..
        } => {
            let phi = state.var(Type::Int);
            let lhs = walk(lhs, state);
            let false_label = format!("{}.{}.false", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;
            state.push(Instruction::JumpIfZero(lhs, false_label.clone()));
            let rhs = walk(rhs, state);
            state.push(Instruction::JumpIfZero(rhs, false_label.clone()));
            state.push(Instruction::Copy {
                src: constant(phi.ty(), 1),
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(false_label));
            state.push(Instruction::Copy {
                src: constant(phi.ty(), 0),
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));

            phi
        }
        Expression::Binary {
            op: BinaryOperator::Or,
            lhs,
            rhs,
            ..
        } => {
            let phi = state.var(Type::Int);
            let lhs = walk(lhs, state);
            let true_label = format!("{}.{}.true", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;
            state.push(Instruction::JumpIfNotZero(lhs, true_label.clone()));
            let rhs = walk(rhs, state);
            state.push(Instruction::JumpIfNotZero(rhs, true_label.clone()));
            state.push(Instruction::Copy {
                src: constant(phi.ty(), 0),
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(true_label));
            state.push(Instruction::Copy {
                src: constant(phi.ty(), 1),
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));

            phi
        }
        Expression::Binary { op, lhs, rhs, .. } => {
            let lhs = walk(lhs, state);
            let rhs = walk(rhs, state);

            let dst = state.var(lhs.ty());
            state.push(Instruction::Binary {
                op: *op,
                lhs,
                rhs,
                dst: dst.clone(),
            });
            dst
        }
        Expression::Var { name, .. } => {
            Val::Var(name.clone(), state.symbols.get(name).unwrap().ty.clone())
        }
        Expression::Assignment { lhs, rhs, .. } => {
            let rhs = walk(rhs, state);
            let lhs = walk(lhs, state);
            assert_eq!(lhs.ty(), rhs.ty(), "{lhs:?} {rhs:?}");
            state.push(Instruction::Copy {
                src: rhs,
                dst: lhs.clone(),
            });
            lhs
        }
        Expression::CompoundAssignment { lhs, op, rhs, .. } => {
            let rhs = walk(rhs, state);
            let lhs = walk(lhs, state);
            assert_eq!(lhs.ty(), rhs.ty(), "{lhs:?} {op:?} {rhs:?}");
            state.push(Instruction::Binary {
                op: *op,
                lhs: lhs.clone(),
                rhs,
                dst: lhs.clone(),
            });
            lhs
        }
        Expression::Ternary {
            cond,
            if_true,
            if_false,
            ..
        } => {
            let else_label = format!("{}.{}.true", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;

            let cond = walk(cond, state);
            state.push(Instruction::JumpIfZero(cond, else_label.clone()));
            let src = walk(if_true, state);
            let phi = state.var(src.ty());

            state.push(Instruction::Copy {
                src,
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(else_label));
            let src = walk(if_false, state);
            state.push(Instruction::Copy {
                src,
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));
            phi
        }
        Expression::FunctionCall {
            function, params, ..
        } => {
            let params = params.iter().map(|e| walk(e, state)).collect::<Vec<_>>();
            match function.as_ref() {
                Expression::Var { name, .. } => {
                    let Type::Function { params: _, ref ret } = state.symbols.get(name).unwrap().ty
                    else {
                        unreachable!()
                    };
                    let dst = state.var(ret.as_ref().clone());
                    state.push(Instruction::Call(name.clone(), params, dst.clone()));
                    dst
                }
                _ => unreachable!(),
            }
        }
        Expression::Cast { to, expr, .. } => {
            use Type::*;
            let src = walk(expr, state);
            match (src.ty(), to) {
                (Function { .. }, _) | (_, Function { .. }) => unreachable!(),
                (from, t) if from == *t => src,
                (Int, Long | ULong) => {
                    let dst = state.var(to.clone());
                    state.push(Instruction::SignExtend {
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                (Long | ULong, Int | UInt) => {
                    let dst = state.var(to.clone());
                    state.push(Instruction::Truncate {
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                (UInt, Int) | (Int, UInt) | (Long, ULong) | (ULong, Long) => {
                    let dst = state.var(to.clone());
                    state.push(Instruction::Copy {
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }

                (UInt, Long | ULong) => {
                    let dst = state.var(to.clone());
                    state.push(Instruction::ZeroExtend {
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                (from, to) => unreachable!("cast {expr:?} from {from:?} to {to:?}"),
            }
        }
    }
}

fn walk_optional<'i>(expr: &Option<Expression>, state: &mut State<'i>) -> Option<Val> {
    expr.as_ref().map(|e| walk(e, state))
}

fn walk_statement<'i>(statement: &Statement, state: &mut State<'i>) {
    match statement {
        Statement::Return(expression) => {
            let ret = walk(expression, state);
            state.push(Instruction::Return(ret));
        }
        Statement::Expression(expression) => {
            walk(expression, state);
        }
        Statement::If {
            cond,
            if_true: then,
            if_false: r#else,
        } => {
            let else_label = format!("{}.{}.true", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;

            let cond = walk(cond, state);
            state.push(Instruction::JumpIfZero(cond, else_label.clone()));
            walk_statement(then, state);
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(else_label));
            if let Some(r#else) = r#else {
                walk_statement(r#else, state);
            }
            state.push(Instruction::Label(end_label));
        }
        Statement::Goto { label, span: _ } => {
            state.push(Instruction::Jump(format!("{}.{label}", state.name)));
        }
        Statement::Labeled {
            label,
            statement,
            span: _,
        } => {
            state.push(Instruction::Label(format!("{}.{label}", state.name)));
            walk_statement(statement, state);
        }
        Statement::Compound(block) => {
            walk_block(block, state);
        }
        Statement::Null => {}
        Statement::Break { label, span: _ } => {
            state.push(Instruction::Jump(label.as_ref().unwrap().clone()));
        }
        Statement::Continue { label, span: _ } => {
            let label = label.as_ref().unwrap();
            state.push(Instruction::Jump(format!("{label}.start")));
        }
        Statement::While {
            expression,
            statement,
            label,
        } => {
            let label = label.as_ref().unwrap();
            let start_label = format!("{label}.start");

            state.push(Instruction::Label(start_label.clone()));
            let cond = walk(expression, state);
            state.push(Instruction::JumpIfZero(cond, label.clone()));

            walk_statement(statement, state);
            state.push(Instruction::Jump(start_label));

            state.push(Instruction::Label(label.clone()));
        }
        Statement::DoWhile {
            statement,
            expression,
            label,
        } => {
            let label = label.as_ref().unwrap();
            let head_label = format!("{label}.head");
            let start_label = format!("{label}.start");

            state.push(Instruction::Label(head_label.clone()));
            walk_statement(statement, state);
            state.push(Instruction::Label(start_label));

            let cond = walk(expression, state);
            state.push(Instruction::JumpIfNotZero(cond, head_label));

            state.push(Instruction::Label(label.clone()));
        }
        Statement::For {
            init,
            condition,
            post,
            body,
            label,
        } => {
            let end_label = label.as_ref().unwrap().clone();
            let cond_label = format!("{end_label}.cond");
            let start_label = format!("{end_label}.start");

            match init {
                ast::ForInit::Decl(variable_declaration) => {
                    lower_variable_declaration(variable_declaration, state)
                }
                ast::ForInit::Expr(expression) => {
                    walk_optional(expression, state);
                }
            };
            state.push(Instruction::Label(cond_label.clone()));

            if let Some(cond) = walk_optional(condition, state) {
                state.push(Instruction::JumpIfZero(cond, end_label.clone()))
            }

            walk_statement(body, state);

            state.push(Instruction::Label(start_label));

            walk_optional(post, state);

            state.push(Instruction::Jump(cond_label));
            state.push(Instruction::Label(end_label));
        }
        Statement::Switch {
            condition: expression,
            body: switch_cases,
            label,
        } => {
            let label = label.as_ref().unwrap();
            let start = format!("{label}.cases");
            let value = walk(expression, state);
            let cmp = state.var(Type::Int);
            state.push(Instruction::Jump(start.clone()));
            state.switch_cases.insert(label.clone(), Default::default());

            walk_statement(switch_cases, state);
            state.push(Instruction::Jump(label.clone()));

            state.push(Instruction::Label(start));
            let cases = state.switch_cases.get(label).unwrap().clone();
            for case in cases {
                match case {
                    Some(case) => {
                        state.push(Instruction::Binary {
                            op: BinaryOperator::Equals,
                            lhs: constant(value.ty(), case),
                            rhs: value.clone(),
                            dst: cmp.clone(),
                        });
                        let case_label = format!(
                            "{}.{}{}",
                            label,
                            if case.is_negative() { "neg" } else { "" },
                            case.abs()
                        );
                        state.push(Instruction::JumpIfNotZero(cmp.clone(), case_label));
                    }
                    None => state.push(Instruction::Jump(format!("{label}.default"))),
                }
            }
            state.push(Instruction::Label(label.clone()));
        }
        Statement::Case {
            expression,
            statement,
            label,
        } => {
            let Val::Constant(c) = walk(expression, state) else {
                unreachable!("non-constant case in switch {expression:?}")
            };
            let case_label = format!(
                "{}.{}{}",
                label.as_ref().unwrap(),
                if c.as_long().is_negative() { "neg" } else { "" },
                c.as_long().abs()
            );
            state.push(Instruction::Label(case_label));
            state
                .switch_cases
                .get_mut(label.as_ref().unwrap())
                .unwrap_or_else(|| panic!("no switch cases registed for {label:?}",))
                .push(Some(c.as_long()));
            walk_statement(statement, state);
        }
        Statement::Default {
            statement,
            label,
            span: _,
        } => {
            state.push(Instruction::Label(format!(
                "{}.default",
                label.as_ref().unwrap()
            )));
            state
                .switch_cases
                .get_mut(label.as_ref().unwrap())
                .unwrap()
                .push(None);
            walk_statement(statement, state);
        }
    }
}

fn walk_declaration<'i>(decl: &Declaration, state: &mut State<'i>) {
    match decl {
        Declaration::Variable(decl) => lower_variable_declaration(decl, state),
        Declaration::Function(_) => {}
    }
}

fn walk_block<'i>(block: &Block, state: &mut State<'i>) {
    for item in block.items.iter() {
        match &item {
            BlockItem::Statement(statement) => walk_statement(statement, state),
            BlockItem::Declaration(decl) => walk_declaration(decl, state),
        }
    }
}

fn lower_function<'a>(
    function: &'a ast::FunctionDeclaration,
    parent_state: &mut State<'a>,
) -> Option<Function> {
    let body = function.body.as_ref()?;
    let mut state = parent_state.function(&function.identifier);

    let params = function
        .params
        .iter()
        .map(|(ty, name, _)| Val::Var(name.clone(), ty.clone()))
        .collect();

    walk_block(body, &mut state);

    state.push(Instruction::Return(constant(function.ret.clone(), 0)));

    for (key, sv) in state.static_variables {
        parent_state.static_variables.entry(key).or_insert(sv);
    }

    Some(Function {
        identifier: function.identifier.clone(),
        global: state
            .symbols
            .get(&function.identifier)
            .is_some_and(|s| s.is_global()),
        params,
        instructions: state.instructions,
    })
}
