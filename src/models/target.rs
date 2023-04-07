use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Target {
    id: String,
    names: Vec<String>,
    created_at: String,
    updated_at: String,
}
