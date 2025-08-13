use std::{fmt::Debug, ops::Range};

use miette::SourceSpan;

#[derive(Clone, PartialEq, Eq)]
pub struct Span(Range<usize>);

impl Span {
    pub fn range(&self) -> Range<usize> {
        self.0.clone()
    }
}

impl Debug for Span {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        self.range().fmt(f)
    }
}

impl From<Span> for SourceSpan {
    fn from(value: Span) -> Self {
        Self::new(value.0.start.into(), value.0.len())
    }
}
impl From<Range<usize>> for Span {
    fn from(value: Range<usize>) -> Self {
        Self(value)
    }
}

impl From<(usize, usize)> for Span {
    fn from((start, len): (usize, usize)) -> Self {
        Self(start..(start + len))
    }
}

pub trait Located {
    fn span(&self) -> Span;
}

impl<T> Located for (Span, T) {
    fn span(&self) -> Span {
        self.0.clone()
    }
}
