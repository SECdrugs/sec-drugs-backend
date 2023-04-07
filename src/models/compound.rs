use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Compound {
    id: String,
    discontinuation_phase: u8,
    discontinuation_reason: u16,
    discontinuation_company_id: String,
    link: String,
    created_at: String,
    updated_at: String,
}
