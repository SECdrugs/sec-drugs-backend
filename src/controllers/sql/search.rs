use sqlx::{Error, PgPool};

use super::deserialize::read_json_row;

pub async fn search_all(pool: &PgPool, term: &str) -> Result<serde_json::Value, Error> {
    let search_query = "SELECT json_build_object(
      'clinical_annotations',
      (
        SELECT json_agg(
            json_build_object('id', id, 'matched_field_value', annotation)
          )
        FROM clinical_annotation
        WHERE annotation ILIKE '%' || ($1) || '%'
      ),
      'companies',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', name))
        FROM company
        WHERE name ILIKE '%' || ($1) || '%'
      ),
      'compound_names',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', name))
        FROM compound_name
        WHERE name ILIKE '%' || ($1) || '%'
      ),
      'diseases',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', name))
        FROM disease
        WHERE name ILIKE '%' || ($1) || '%'
      ),
      'gene_targets',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', gene))
        FROM gene_target
        WHERE gene ILIKE '%' || ($1) || '%'
      ),
      'indications',
      (
        SELECT json_agg(
            json_build_object('id', id, 'matched_field_value', indication)
          )
        FROM indication
        WHERE indication ILIKE '%' || ($1) || '%'
      ),
      'mechanisms_of_action',
      (
        SELECT json_agg(
            json_build_object('id', id, 'matched_field_value', mechanism)
          )
        FROM mechanism_of_action
        WHERE mechanism ILIKE '%' || ($1) || '%'
      ),
      'pathway_annotations',
      (
        SELECT json_agg(
            json_build_object('id', id, 'matched_field_value', annotation)
          )
        FROM pathway_annotation
        WHERE annotation ILIKE '%' || ($1) || '%'
      ),
      'repurposings',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', efforts))
        FROM repurposing
        WHERE efforts ILIKE '%' || ($1) || '%'
      ),
      'targets',
      (
        SELECT json_agg(json_build_object('id', id, 'matched_field_value', names))
        FROM target
        WHERE names::text[] @> ARRAY [($1)]
      )
    ) AS result
  ;";

    let results = sqlx::query(search_query).bind(term).fetch_one(pool).await?;

    let json_result: serde_json::Value = read_json_row(&results);

    Ok(json_result)
}
