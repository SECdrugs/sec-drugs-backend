use actix_web::{get, web, Error, HttpRequest};
use actix_web::{HttpResponse, Result};
use sqlx::PgPool;

use crate::controllers::sql::compound_sql::get_compound_by_id;

#[get("/compound/{id}")]
pub async fn get_compound(
    pool_data: web::Data<PgPool>,
    req: HttpRequest,
) -> Result<HttpResponse, Error> {
    let pool = pool_data.as_ref();
    let compound_id = req.match_info().get("id").unwrap();

    let compound = get_compound_by_id(pool, compound_id).await.unwrap();

    Ok(HttpResponse::Ok().finish())
}
