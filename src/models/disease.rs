use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Disease {
    id: String,
    name: String,
    created_at: String,
    updated_at: String,
}
