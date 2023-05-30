use sqlx::{types::Uuid, Error, PgPool};

use super::deserialize::read_json_row;

fn get_query_for_join_table(table: &str) -> String {
    let query = format!(
        "SELECT jsonb_build_object(
        '{table}', jsonb_agg({table}.*),
        'compounds', jsonb_agg(jsonb_build_object('id', c.id, 'name', cmpn.name))
        )
        INTO result
        FROM {table} t
        JOIN compound_{table} jt ON t.id = jt.{table}_id
        JOIN compound c ON jt.compound_id = c.id
        JOIN compound_name cmpn ON cmp.id = cmpn.id
        WHERE t.id = $1;"
    );

    query
}

fn get_query_for_single_join(table: &str) -> String {
    let query = format!(
        "SELECT jsonb_build_object(
            '{table}', jsonb_agg({table}.*),
            'compounds', jsonb_agg(jsonb_build_object('id', c.id, 'name', cmpn.name))
        )
        INTO result
        FROM {table} t
        JOIN compound c ON t.compound_id = c.id
        JOIN compound_name cmpn ON cmp.id = cmpn.id
        WHERE t.id = $1;"
    );

    query
}

fn get_company_query() -> String {
    let query = ("
    with compounds as (
        select c.id, cmpn.name
        from compound c
        left join repurposing r on r.compound_id = c.id
        inner join compound_compound_name ccn on ccn.compound_id = c.id
        inner join compound_name cmpn on ccn.compound_name_id = cmpn.id or r.compound_name_id = cmpn.id
        where c.discontinuation_company_id = $1 or r.company_id = $1
    )
    select jsonb_build_object(
        'company', (select row_to_json(company) from company where id = $1),
        'compounds', (select jsonb_agg(row_to_json(compounds)) from compounds)
    );")
    .to_string();

    query
}

pub async fn get_compounds_for_attribute(
    pool: &PgPool,
    table: &str,
    str_id: &str,
) -> Result<serde_json::Value, Error> {
    let query = match table {
        "clinical_annotation" => get_query_for_join_table(table),
        "compound_name" => get_query_for_join_table(table),
        "disease" => get_query_for_join_table(table),
        "gene_target" => get_query_for_join_table(table),
        "indication" => get_query_for_join_table(table),
        "mechanism_of_action" => get_query_for_join_table(table),
        "pathway_annotation" => get_query_for_join_table(table),
        "repurposing" => get_query_for_single_join(table),
        "target" => get_query_for_join_table(table),
        "company" => get_company_query(),
        // TODO remove panic here
        _ => panic!("Unrecognized table"),
    };

    let id = Uuid::try_parse(str_id).unwrap();

    let result = sqlx::query(&query).bind(id).fetch_one(pool).await?;

    let json_result: serde_json::Value = read_json_row(&result);

    Ok(json_result)
}
