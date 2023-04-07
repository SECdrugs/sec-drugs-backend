use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Annotation {
    id: String,
    annotation: String,
    created_at: String,
    updated_at: String,
}
