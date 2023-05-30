use actix_web::{get, web, Error, HttpRequest};
use actix_web::{HttpResponse, Result};
use sqlx::PgPool;

use crate::controllers::sql::list::get_compounds_for_attribute;

#[get("/list/{table_name}/{id}")]
pub async fn get_compounds_list(
    pool_data: web::Data<PgPool>,
    req: HttpRequest,
) -> Result<HttpResponse, Error> {
    let pool = pool_data.as_ref();
    let table_name = req.match_info().get("table_name").unwrap();
    let id = req.match_info().get("id").unwrap();

    let compounds = get_compounds_for_attribute(pool, table_name, id)
        .await
        .unwrap();

    Ok(HttpResponse::Ok().json(compounds))
}
