use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Clone, Serialize, Deserialize, FromRow)]
pub struct Indication {
    id: String,
    indication: String,
    #[serde(alias = "type")]
    indication_type: String,
}
