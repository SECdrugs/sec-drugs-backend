use actix_web::{http::header::ContentType, post, web, HttpResponse, Responder};
use sqlx::{types::Uuid, Error, PgPool};

use crate::{controllers::utils::convert_sqlx_error, models::create_model::CreateModel};

#[post("/create")]
async fn create(
    pool_data: web::Data<PgPool>,
    compound_json: web::Json<CreateModel>,
) -> impl Responder {
    let model = compound_json.0;

    let pool = &pool_data.as_ref();

    let compound_name_ids = add_compound_names(pool, model)
        .await
        .map_err(convert_sqlx_error)
        .unwrap();

    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body("test")
}

async fn add_compound_names(pool: &PgPool, model: CreateModel) -> Result<Vec<String>, Error> {
    let insert_query = "insert into compound_name (name, is_repurposed) values ($1, false)
                            returning id new_id;";
    let mut compound_name_ids: Vec<String> = vec![];
    for compound_name in model.names {
        let new_id: Uuid = sqlx::query_scalar(insert_query)
            .bind(&compound_name)
            .fetch_one(pool)
            .await?;
        compound_name_ids.push(new_id.to_string());
    }

    Ok(compound_name_ids)
}
