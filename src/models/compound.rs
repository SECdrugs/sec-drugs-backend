use sqlx::{
    types::{chrono::NaiveDateTime, Uuid},
    FromRow,
};

#[derive(Clone, FromRow)]
pub struct Compound {
    id: Uuid,
    discontinuation_phase: i32,
    discontinuation_reason: String,
    discontinuation_company_id: Uuid,
    link: String,
    created_at: NaiveDateTime,
    updated_at: NaiveDateTime,
}
