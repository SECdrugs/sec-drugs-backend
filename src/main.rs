use actix_cors::Cors;
use actix_web::{
    get, http::header::ContentType, middleware::Logger, web::Data, App, HttpResponse, HttpServer,
    Responder,
};
mod controllers;
mod models;
use controllers::{
    compound::get_compound, create::create, list::get_compounds_list, search::search,
};
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
        let cors = Cors::default().allow_any_origin().send_wildcard();

        App::new()
            .app_data(Data::new(pool.clone()))
            .wrap(logger)
            .wrap(cors)
            .service(index)
            .service(create)
            .service(get_compound)
            .service(search)
            .service(get_compounds_list)
    })
    .bind(("127.0.0.1", 8000))?
    .run()
    .await
}
