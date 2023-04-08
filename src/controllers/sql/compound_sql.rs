use sqlx::{
    postgres::PgRow,
    types::{JsonValue, Uuid},
    Error, PgPool,
};

use crate::models::{compound::Compound, disease::Disease};

pub async fn get_compound_by_id(pool: &PgPool, compound_id_str: &str) -> Result<Compound, Error> {
    let search_query = "select * from compound where id = $1;";

    let compound_id = Uuid::try_parse(compound_id_str).unwrap();

    let compound = sqlx::query_as::<_, Compound>(search_query)
        .bind(compound_id)
        .fetch_one(pool)
        .await?;

    let diseases_json = get_compound_join_field(pool, compound_id, "disease", vec!["id", "name"])
        .await
        .unwrap();

    return Ok(compound);
}

async fn get_compound_join_field(
    pool: &PgPool,
    compound_id: Uuid,
    table: &str,
    columns: Vec<&str>,
) -> Result<serde_json::Value, Error> {
    let column_string = columns.join(", ");
    let search_query = format!(
        "with results as (
            select {column_string} from
            compound_{table} j1 
            inner join {table} t1 on t1.id = j1.{table}_id
            where j1.compound_id = $1
        )
        select to_json(results.*)
        from results;"
    );

    let rows: serde_json::Value = sqlx::query_scalar(&search_query)
        .bind(compound_id)
        .fetch_one(pool)
        .await?;

    Ok(rows)
}

// async fn get_diseases(pool: &PgPool, compound_id: Uuid) -> Result<Vec<Disease>, Error> {
//     let disease_rows = get_compound_join_field(pool, compound_id, "disease", vec!["name"])
//         .await
//         .unwrap();

//     let diseases: Vec<Disease> = disease_rows
//         .iter()
//         .map(|row| row.try_into().unwrap())
//         .collect();

//     Ok(diseases)
// }

async fn get_pathway_annotations(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_mechanism_of_action(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_targets(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_gene_targets(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_clinical_annotations(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_company(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_compound_name(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_indication(pool: &PgPool, compound_id: Uuid) -> () {}

async fn get_repurposing(pool: &PgPool, compound_id: Uuid) -> () {}
