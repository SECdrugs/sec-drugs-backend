use serde::{Deserialize, Serialize};

#[derive(Clone, Deserialize, Serialize)]
pub struct Target {
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
    pub targets: Vec<Target>,
    pub mechanism_of_action: Vec<String>,
    pub indications: Vec<String>,
    pub indication_type: String,
    pub year_discontinued: i16,
    pub phase: i8,
    pub discontinuation_reason: String,
    pub link: String,
    pub repurposed_efforts: Option<String>,
    pub repurposed_drug_name: Option<String>,
    pub repurposed_indications: Vec<String>,
    pub repurposed_year: Option<i16>,
    pub repurposed_company: Option<String>,
    pub repurposed_phase: Option<i16>,
}
