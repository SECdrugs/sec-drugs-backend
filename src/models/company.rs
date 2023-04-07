use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Company {
    id: String,
    name: String,
    created_at: String,
    updated_at: String,
}
