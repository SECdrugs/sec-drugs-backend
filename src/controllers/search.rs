use actix_web::{get, web, Error, HttpResponse};
use serde::Deserialize;
use sqlx::PgPool;

use super::sql::search::search_all;

#[derive(Deserialize)]
pub struct SearchQuery {
    q: String,
}

#[get("/search")]
pub async fn search(
    pool_data: web::Data<PgPool>,
    query: web::Query<SearchQuery>,
) -> Result<HttpResponse, Error> {
    let pool = pool_data.as_ref();

    let search_term = query.q.as_str();

    let results = search_all(pool, search_term).await.unwrap();

    Ok(HttpResponse::Ok().json(results))
}
