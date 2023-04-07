use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct GeneTarget {
    id: String,
    gene: String,
    created_at: String,
    updated_at: String,
}
