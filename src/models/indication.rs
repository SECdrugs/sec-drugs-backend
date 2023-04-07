use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct Indication {
    id: String,
    indication_type_id: String,
    indication: String,
    created_at: String,
    updated_at: String,
    #[serde(alias = "type")]
    indication_type: String,
}
