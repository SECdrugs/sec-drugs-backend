use actix_web::{get, web, HttpRequest, HttpResponse, Responder};
use sqlx::{types::Uuid, Error, PgPool};

#[get("/compound/{id}")]
pub async fn get_compound(pool_data: web::Data<PgPool>, req: HttpRequest) -> impl Responder {
    let pool = &pool_data.as_ref();
    let compound_id = req.match_info().get("id").unwrap();

    // let compound_id = req.
    HttpResponse::Ok()
}
