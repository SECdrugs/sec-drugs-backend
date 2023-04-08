use serde::Serialize;
use sqlx::FromRow;

use super::create_model::Indication;

#[derive(Clone, Serialize, FromRow)]
pub struct CompoundApiModel {
    id: String,
    names: Vec<String>,
    company: String,
    company_id: String,
    discontinuation_phase: i32,
    discontinuation_reason: String,
    discontinuation_company_id: String,
    link: String,
    created_at: String,
    updated_at: String,
    mechanisms_of_action: Vec<String>,
    diseases: Vec<String>,
    pathway_annotations: Vec<String>,
    clinical_annotations: Vec<String>,
    targets: Vec<Vec<String>>,
    gene_targets: Vec<String>,
    indications: Vec<Indication>,
    repurposing_id: String,
    name: String,
    repurposing_company: String,
    repurposing_year: i32,
    repurposing_phase: i32,
    repurposing_efforts: String,
    repurposing_indications: Vec<Indication>,
    repurposing_updated_at: String,
}

#[derive(Clone, Serialize)]
pub struct RepurposingApiModel {
    id: String,
    name: String,
    company: String,
    year: i32,
    phase: i32,
    efforts: String,
    indications: Vec<Indication>,
    created_at: String,
    updated_at: String,
}
