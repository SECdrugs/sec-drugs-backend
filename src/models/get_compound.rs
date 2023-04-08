use serde::Serialize;

use super::{
    annotation::Annotation, company::Company, compound_name::CompoundName,
    create_model::Indication, disease::Disease, gene_target::GeneTarget,
    mechanism_of_actions::MechanismOfAction, target::Target,
};

#[derive(Clone, Serialize)]
pub struct CompoundApiModel {
    id: String,
    names: Vec<CompoundName>,
    company: Company,
    discontinuation_phase: i32,
    discontinuation_reason: String,
    discontinuation_company_id: String,
    link: String,
    created_at: String,
    updated_at: String,
    mechanisms_of_action: Vec<MechanismOfAction>,
    diseases: Vec<Disease>,
    pathway_annotations: Vec<Annotation>,
    clinical_annotations: Vec<Annotation>,
    targets: Vec<Target>,
    gene_targets: Vec<GeneTarget>,
    indications: Vec<Indication>,
    repurposing: Option<RepurposingApiModel>,
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
