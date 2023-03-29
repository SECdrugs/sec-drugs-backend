use std::io::{Error, ErrorKind};

pub fn convert_sqlx_error(err: sqlx::Error) -> std::io::Error {
    // TODO This is terrible, need to fix
    Error::new(ErrorKind::Other, err.to_string())
}
