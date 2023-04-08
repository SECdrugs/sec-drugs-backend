# cddd-backend

## Cardio Discontinued Drug Database

This is the backend code for CDDD. The backend uses the [actix](https://actix.rs/) web framework with [sqlx](https://github.com/launchbadge/sqlx) and Postgres.

-------------

## Status

This is a very early stage **work in progress**. This means that the code is not written very well, and the backend is not robust.

The code may also be inefficient and not idiomatic, since I'm a rust novice.

## Development
To run, enter `cargo run`. For live reloading, try `cargo watch -x run`.

## TODOs
- [ ] Read database connection string from .env
- [ ] Require an API key to use `/create` endpoint
- [ ] Important: Put entire create logic in one SQL query and wrap it in a transaction