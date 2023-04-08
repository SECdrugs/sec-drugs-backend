use serde::{Deserialize, Serialize};

#[derive(Clone, Deserialize, Serialize)]
pub struct CreateTarget {
    pub names: Vec<String>,
}

#[derive(Clone, Deserialize, Serialize)]
pub struct Indication {
    pub indication: String,
    pub indication_type: String,
}

#[derive(Clone, Deserialize, Serialize)]
pub struct CreateModel {
    pub names: Vec<String>,
    pub company: String,
    pub genes: Vec<String>,
    pub clinical_annotation: Vec<String>,
    pub pathway_annotation: Vec<String>,
    pub diseases: Vec<String>,
    pub targets: Vec<CreateTarget>,
    pub mechanism_of_action: Vec<String>,
    pub indications: Vec<String>,
    pub indication_type: String,
    pub year_discontinued: i32,
    pub phase: i32,
    pub discontinuation_reason: String,
    pub link: String,
    pub repurposed_efforts: Option<String>,
    pub repurposed_drug_name: Option<String>,
    pub repurposed_indications: Vec<String>,
    pub repurposed_year: Option<i32>,
    pub repurposed_company: Option<String>,
    pub repurposed_phase: Option<i32>,
}
