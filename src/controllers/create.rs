use actix_web::{http::header::ContentType, post, web, HttpResponse, Responder};
use sqlx::PgPool;

use crate::{
    controllers::{
        sql::create_sql::{
            add_compound, add_compound_names, add_or_fetch_indications, add_or_fetch_input_vec,
            add_or_fetch_targets, add_repurposing, create_join,
        },
        utils::convert_sqlx_error,
    },
    models::create_model::CreateModel,
};

#[post("/create")]
async fn create(
    pool_data: web::Data<PgPool>,
    compound_json: web::Json<CreateModel>,
) -> impl Responder {
    let model = compound_json.0;

    let pool = &pool_data.as_ref();

    // add compound √
    // add compound names √
    // add indications (including indication types)
    // add MOA √
    // add diseases √
    // add pathway annotations √
    // add targets (including target names) √
    // add gene targets √
    // add clinical annotations √

    // REPURPOSING
    // add repurposing compound name √
    // add repurposing √
    // add repurposing efforts √
    // add repurposing indications √

    // join compound and repurposing

    let compound_id = add_compound(pool, model.clone())
        .await
        .map_err(convert_sqlx_error)
        .unwrap();

    let compound_name_ids = add_compound_names(pool, model.names.clone())
        .await
        .map_err(convert_sqlx_error)
        .unwrap();

    // Create join table for compound and compound_name
    for compound_name_id in compound_name_ids {
        create_join(
            pool,
            "compound",
            "compound_name",
            compound_id,
            compound_name_id,
        )
        .await
        .unwrap();
    }

    // Insert indications
    let indication_ids = add_or_fetch_indications(
        pool,
        model.clone().indications,
        Some(model.indication_type.clone()),
    )
    .await
    .unwrap();

    for indication_id in indication_ids.clone() {
        create_join(pool, "compound", "indication", compound_id, indication_id)
            .await
            .unwrap();
    }

    // Mechanism of action
    let moa_ids = add_or_fetch_input_vec(
        pool,
        model.mechanism_of_action.clone(),
        "mechanism_of_action".to_string(),
        "mechanism".to_string(),
    )
    .await
    .unwrap();

    for moa_id in moa_ids {
        create_join(pool, "compound", "mechanism_of_action", compound_id, moa_id)
            .await
            .unwrap();
    }

    // Diseases
    let disease_ids = add_or_fetch_input_vec(
        pool,
        model.diseases.clone(),
        "disease".to_string(),
        "name".to_string(),
    )
    .await
    .unwrap();

    for disease_id in disease_ids {
        create_join(pool, "compound", "disease", compound_id, disease_id)
            .await
            .unwrap();
    }

    // Pathway Annotations
    let pathway_annotation_ids = add_or_fetch_input_vec(
        pool,
        model.pathway_annotation.clone(),
        "pathway_annotation".to_string(),
        "annotation".to_string(),
    )
    .await
    .unwrap();

    for p_id in pathway_annotation_ids {
        create_join(pool, "compound", "pathway_annotation", compound_id, p_id)
            .await
            .unwrap();
    }

    // Clinical Annotations
    let clinical_annotation_ids = add_or_fetch_input_vec(
        pool,
        model.clinical_annotation.clone(),
        "clinical_annotation".to_string(),
        "annotation".to_string(),
    )
    .await
    .unwrap();

    for clin_id in clinical_annotation_ids {
        create_join(
            pool,
            "compound",
            "clinical_annotation",
            compound_id,
            clin_id,
        )
        .await
        .unwrap();
    }

    // Gene/Gene Targets
    let gene_ids = add_or_fetch_input_vec(
        pool,
        model.genes.clone(),
        "gene_target".to_string(),
        "gene".to_string(),
    )
    .await
    .unwrap();

    for gene_id in gene_ids {
        create_join(pool, "compound", "gene_target", compound_id, gene_id)
            .await
            .unwrap();
    }

    // Targets
    let target_ids = add_or_fetch_targets(pool, model.targets.clone())
        .await
        .unwrap();

    for target_id in target_ids {
        create_join(pool, "compound", "target", compound_id, target_id)
            .await
            .unwrap();
    }

    // Reporposing
    if !model.repurposed_efforts.is_none() {
        let repurposing_id = add_repurposing(pool, model.clone(), compound_id)
            .await
            .unwrap();
        let repurposing_indication_ids =
            add_or_fetch_indications(pool, model.indications.clone(), None)
                .await
                .unwrap();

        for r_indication_id in repurposing_indication_ids {
            create_join(
                pool,
                "repurposing",
                "indication",
                repurposing_id,
                r_indication_id,
            )
            .await
            .unwrap();
        }

        create_join(pool, "compound", "repurposing", compound_id, repurposing_id)
            .await
            .unwrap();
    }

    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body(indication_ids.len().to_string())
}
