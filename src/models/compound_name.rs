use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct CompoundName {
    id: String,
    name: String,
    is_repurposed: bool,
    created_at: String,
    updated_at: String,
}
