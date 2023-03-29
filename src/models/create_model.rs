use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
struct Target {
    names: Vec<String>,
}

#[derive(Deserialize, Serialize)]
struct Indication {
    indication: String,
    indication_type: String,
}

#[derive(Deserialize, Serialize)]
struct Repurposing {
    year: u16,
}

#[derive(Deserialize, Serialize)]
pub struct CreateModel {
    names: Vec<String>,
    company: String,
    genes: Vec<String>,
    clinical_annotation: Vec<String>,
    pathway_annotation: Vec<String>,
    diseases: Vec<String>,
    targets: Vec<Target>,
    mechanism_of_action: Vec<String>,
    indications: Vec<String>,
    indication_type: String,
    year_discontinued: u16,
    phase: u8,
    discontinuation_reason: String,
    link: String,
    repurposed_efforts: Vec<String>,
    repurposed_drug_name: String,
    repurposed_indications: Vec<String>,
    repurposed_year: Option<u32>,
    repurposed_company: Option<String>,
    repurposed_phase: Option<u8>,
}
