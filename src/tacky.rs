use std::collections::HashMap;

pub use crate::parser::BinaryOperator;
use crate::{
    parser::{self, Block, BlockItem, Declaration, Expression, Statement, VariableDeclaration},
    sema::{self, SymbolAttributes, SymbolTable},
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
    pub init: i32,
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
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Val {
    Constant(i32),
    Var(String),
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
    switch_cases: HashMap<String, Vec<Option<i32>>>,
    symbols: &'i SymbolTable,
    static_variables: HashMap<String, StaticVariable>,
}
impl<'i> State<'i> {
    fn var(&mut self) -> Val {
        let v = Val::Var(format!("{}.tmp.{}", self.name, self.temps));
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

pub fn lower(program: &parser::Program, symbols: &sema::SymbolTable) -> Program {
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
                });
        }
        SymbolAttributes::Local => {
            let var = Val::Var(decl.name.clone());
            if let Some(rhs) = walk_optional(&decl.init, state) {
                state.push(Instruction::Copy { src: rhs, dst: var })
            }
        }
    }
}

fn walk<'i>(expr: &Expression, state: &mut State<'i>) -> Val {
    match expr {
        Expression::Constant(val) => Val::Constant(*val),
        Expression::Unary(unary_operator, expression) => {
            let src = walk(expression, state);
            match unary_operator {
                parser::UnaryOperator::Minus => {
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Negate,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                parser::UnaryOperator::Complement => {
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Complement,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                parser::UnaryOperator::Not => {
                    let dst = state.var();
                    state.push(Instruction::Unary {
                        op: UnaryOperator::Not,
                        src,
                        dst: dst.clone(),
                    });
                    dst
                }
                parser::UnaryOperator::PrefixIncrement => {
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: Val::Constant(1),
                        dst: src.clone(),
                    });
                    src
                }
                parser::UnaryOperator::PrefixDecrement => {
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: Val::Constant(-1),
                        dst: src.clone(),
                    });
                    src.clone()
                }
                parser::UnaryOperator::PostfixIncrement => {
                    let dst = state.var();
                    state.push(Instruction::Copy {
                        src: src.clone(),
                        dst: dst.clone(),
                    });
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: Val::Constant(1),
                        dst: src.clone(),
                    });
                    dst
                }
                parser::UnaryOperator::PostfixDecrement => {
                    let dst = state.var();
                    state.push(Instruction::Copy {
                        src: src.clone(),
                        dst: dst.clone(),
                    });
                    state.push(Instruction::Binary {
                        op: BinaryOperator::Add,
                        lhs: src.clone(),
                        rhs: Val::Constant(-1),
                        dst: src.clone(),
                    });
                    dst
                }
            }
        }
        Expression::Binary(BinaryOperator::And, lhs, rhs) => {
            let phi = state.var();
            let lhs = walk(lhs, state);
            let false_label = format!("{}.{}.false", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;
            state.push(Instruction::JumpIfZero(lhs, false_label.clone()));
            let rhs = walk(rhs, state);
            state.push(Instruction::JumpIfZero(rhs, false_label.clone()));
            state.push(Instruction::Copy {
                src: Val::Constant(1),
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(false_label));
            state.push(Instruction::Copy {
                src: Val::Constant(0),
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));

            phi
        }
        Expression::Binary(BinaryOperator::Or, lhs, rhs) => {
            let phi = state.var();
            let lhs = walk(lhs, state);
            let true_label = format!("{}.{}.true", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;
            state.push(Instruction::JumpIfNotZero(lhs, true_label.clone()));
            let rhs = walk(rhs, state);
            state.push(Instruction::JumpIfNotZero(rhs, true_label.clone()));
            state.push(Instruction::Copy {
                src: Val::Constant(0),
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(true_label));
            state.push(Instruction::Copy {
                src: Val::Constant(1),
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));

            phi
        }
        Expression::Binary(op, lhs, rhs) => {
            let lhs = walk(lhs, state);
            let rhs = walk(rhs, state);
            let dst = state.var();
            state.push(Instruction::Binary {
                op: *op,
                lhs,
                rhs,
                dst: dst.clone(),
            });
            dst
        }
        Expression::Var(name) => Val::Var(name.clone()),
        Expression::Assignment(lhs, rhs) => {
            let rhs = walk(rhs, state);
            let lhs = walk(lhs, state);
            state.push(Instruction::Copy {
                src: rhs,
                dst: lhs.clone(),
            });
            lhs
        }
        Expression::CompoundAssignment(lhs, op, rhs) => {
            let rhs = walk(rhs, state);
            let lhs = walk(lhs, state);
            state.push(Instruction::Binary {
                op: *op,
                lhs: lhs.clone(),
                rhs,
                dst: lhs.clone(),
            });
            lhs
        }
        Expression::Ternary(cond, then, r#else) => {
            let phi = state.var();
            let else_label = format!("{}.{}.true", state.name, state.phis);
            let end_label = format!("{}.{}.end", state.name, state.phis);
            state.phis += 1;

            let cond = walk(cond, state);
            state.push(Instruction::JumpIfZero(cond, else_label.clone()));
            let src = walk(then, state);
            state.push(Instruction::Copy {
                src,
                dst: phi.clone(),
            });
            state.push(Instruction::Jump(end_label.clone()));
            state.push(Instruction::Label(else_label));
            let src = walk(r#else, state);
            state.push(Instruction::Copy {
                src,
                dst: phi.clone(),
            });
            state.push(Instruction::Label(end_label));
            phi
        }
        Expression::FunctionCall(ident, expressions) => {
            let params = expressions
                .iter()
                .map(|e| walk(e, state))
                .collect::<Vec<_>>();
            match ident.as_ref() {
                Expression::Var(name) => {
                    let dst = state.var();
                    state.push(Instruction::Call(name.clone(), params, dst.clone()));
                    dst
                }
                _ => unreachable!(),
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
        Statement::If(cond, then, r#else) => {
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
        Statement::Goto(label) => {
            state.push(Instruction::Jump(format!("{}.{label}", state.name)));
        }
        Statement::Labeled(label, statement) => {
            state.push(Instruction::Label(format!("{}.{label}", state.name)));
            walk_statement(statement, state);
        }
        Statement::Compound(block) => {
            walk_block(block, state);
        }
        Statement::Null => {}
        Statement::Break(label) => {
            state.push(Instruction::Jump(label.as_ref().unwrap().clone()));
        }
        Statement::Continue(label) => {
            let label = label.as_ref().unwrap();
            state.push(Instruction::Jump(format!("{label}.start")));
        }
        Statement::While(expression, statement, label) => {
            let label = label.as_ref().unwrap();
            let start_label = format!("{label}.start");

            state.push(Instruction::Label(start_label.clone()));
            let cond = walk(expression, state);
            state.push(Instruction::JumpIfZero(cond, label.clone()));

            walk_statement(statement, state);
            state.push(Instruction::Jump(start_label));

            state.push(Instruction::Label(label.clone()));
        }
        Statement::DoWhile(statement, expression, label) => {
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
                parser::ForInit::Decl(variable_declaration) => {
                    lower_variable_declaration(variable_declaration, state)
                }
                parser::ForInit::Expr(expression) => {
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
        Statement::Switch(expression, switch_cases, label) => {
            let label = label.as_ref().unwrap();
            let start = format!("{label}.cases");
            let value = walk(expression, state);
            let cmp = state.var();
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
                            lhs: Val::Constant(case),
                            rhs: value.clone(),
                            dst: cmp.clone(),
                        });
                        state.push(Instruction::JumpIfNotZero(
                            cmp.clone(),
                            format!("{label}.{case}"),
                        ));
                    }
                    None => state.push(Instruction::Jump(format!("{label}.default"))),
                }
            }
            state.push(Instruction::Label(label.clone()));
        }
        Statement::Case(expression, statement, label) => {
            let Val::Constant(c) = walk(expression, state) else {
                unreachable!()
            };
            state.push(Instruction::Label(format!(
                "{}.{c}",
                label.as_ref().unwrap()
            )));
            state
                .switch_cases
                .get_mut(label.as_ref().unwrap())
                .unwrap_or_else(|| panic!("no switch cases registed for {label:?}",))
                .push(Some(c));
            walk_statement(statement, state);
        }
        Statement::Default(statement, label) => {
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
    function: &'a parser::FunctionDeclaration,
    parent_state: &mut State<'a>,
) -> Option<Function> {
    let body = function.body.as_ref()?;
    let mut state = parent_state.function(&function.identifier);

    let params = function
        .params
        .iter()
        .map(|param| Val::Var(param.clone()))
        .collect();

    walk_block(body, &mut state);

    state.push(Instruction::Return(Val::Constant(0)));

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
