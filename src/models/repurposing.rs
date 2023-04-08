use sqlx::{types::Uuid, FromRow};

#[derive(Clone, FromRow)]
pub struct Repurposing {
    id: Uuid,
    compound_id: Uuid,
    compound_name_id: Uuid,
    company_id: Uuid,
    year: i32,
    phase: i32,
    efforts: String,
}
