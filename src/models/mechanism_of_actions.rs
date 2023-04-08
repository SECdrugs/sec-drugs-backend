use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Clone, Serialize, Deserialize, FromRow)]
pub struct MechanismOfAction {
    id: String,
    mechanism: String,
}
