use actix_web::{
    get, http::header::ContentType, middleware::Logger, web::Data, App, HttpResponse, HttpServer,
    Responder,
};
mod controllers;
mod models;
use controllers::create::create;
use sqlx::postgres::PgPoolOptions;

#[get("/")]
async fn index() -> impl Responder {
    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body("{ status: running }")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "debug");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // Create DB connection pool
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect("postgres://cddd@localhost/cddd_dev")
        .await
        .expect("Failed to create pool");

    HttpServer::new(move || {
        let logger = Logger::default();

        App::new()
            .app_data(Data::new(pool.clone()))
            .wrap(logger)
            .service(index)
            .service(create)
    })
    .bind(("127.0.0.1", 8000))?
    .run()
    .await
}