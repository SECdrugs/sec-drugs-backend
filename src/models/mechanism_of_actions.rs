use serde::{Deserialize, Serialize};

#[derive(Clone, Serialize, Deserialize)]
pub struct MechanismOfAction {
    id: String,
    mechanism: String,
    created_at: String,
    updated_at: String,
}
