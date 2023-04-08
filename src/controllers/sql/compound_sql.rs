use sqlx::{types::Uuid, Error, PgPool};

use super::deserialize::read_json_row;

pub async fn get_compound_by_id(
    pool: &PgPool,
    compound_id_str: &str,
) -> Result<serde_json::Value, Error> {
    let search_query = "with compound_info as (
        select c.id,
          c.discontinuation_phase,
          c.discontinuation_reason,
          c.discontinuation_year,
          c.link,
          c.created_at,
          c.updated_at,
          company.name,
          company.id as company_id
        from compound c
          inner join company on company.id = c.discontinuation_company_id
        where c.id = $1
      ),
      mechanisms_of_action as (
        select json_agg(mechanism) as mechanisms_of_action
        from mechanism_of_action t1
          inner join compound_mechanism_of_action j1 on j1.mechanism_of_action_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      diseases as (
        select json_agg(t1.name) diseases
        from disease t1
          inner join compound_disease j1 on j1.disease_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      pathway_annotations as (
        select json_agg(annotation) pathway_annotations
        from pathway_annotation t1
          inner join compound_pathway_annotation j1 on j1.pathway_annotation_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      targets as (
        select json_agg(names) targets
        from target t1
          inner join compound_target j1 on j1.target_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      gene_targets as (
        select json_agg(gene) gene_targets
        from gene_target t1
          inner join compound_gene_target j1 on j1.gene_target_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      clinical_annotations as (
        select json_agg(annotation) clinical_annotations
        from clinical_annotation t1
          inner join compound_clinical_annotation j1 on j1.clinical_annotation_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      compound_names as (
        select json_agg(name) names
        from compound_name t1
          inner join compound_compound_name j1 on j1.compound_name_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      -- TODO add indication type
      indications as (
        select json_agg(indication) indications
        from indication t1
          inner join compound_indication j1 on j1.indication_id = t1.id
        where j1.compound_id = (
            select id
            from compound_info
          )
      ),
      repurposing as (
        select r.id as repurposing_id,
          compound_name.name as name,
          c.name as company,
          r.year as repurposing_year,
          r.phase as repurposing_phase,
          r.efforts as repurposing_efforts,
          r.updated_at as repurposing_updated_at
        from repurposing r
          join company c on r.company_id = c.id
          join compound_name on r.compound_name_id = compound_name.id
        where r.compound_id = (
            select id
            from compound_info
          )
      ),
      repurposing_indications as (
        select json_agg(indication) repurposing_indications
        from indication t1
          inner join repurposing_indication j1 on j1.indication_id = t1.id
        where j1.repurposing_id = (
            select id
            from repurposing
          )
      ),
      compound_result as (
        select compound_info.*,
          mechanisms_of_action.*,
          diseases.*,
          pathway_annotations.*,
          targets.*,
          gene_targets.*,
          clinical_annotations.*,
          compound_names.*,
          indications.*,
          clinical_annotations.*,
          r.*,
          repurposing_indications.*
        from compound_info as c
          left join compound_info on true
          left join mechanisms_of_action on true
          left join diseases on true
          left join pathway_annotations on true
          left join targets on true
          left join gene_targets on true
          left join clinical_annotations on true
          left join compound_names on true
          left join indications on true
          left join repurposing r on true
          left join repurposing_indications on true
      )
      select to_json(compound_result.*)
      from compound_result;";

    let compound_id = Uuid::try_parse(compound_id_str).unwrap();

    let row = sqlx::query(search_query)
        .bind(compound_id)
        .fetch_one(pool)
        .await?;
    let row: serde_json::Value = read_json_row(&row);

    return Ok(row);
}
