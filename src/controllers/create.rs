use actix_web::{http::header::ContentType, post, web, HttpResponse, Responder};

use crate::models::create_model::CreateModel;

#[post("/create")]
async fn create(compound_json: web::Json<CreateModel>) -> impl Responder {
    let model = compound_json.0;
    let test = serde_json::to_string(&model);

    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body(test.unwrap())
}
