# Backend

Rust API server built with Actix (or similar). Source at `backend/backend/src/`. Runs internally on port 8080 — never exposed to the host, only reachable from nginx within the Docker network.

Config: `backend/config.json`

```json
{
  "root": "/app/root",
  "database_url": "postgres://dbuser:<PG_KEY>@database:5432/vault_db",
  "jwt_secret": "<secret>",
  "username": "<admin user>",
  "password": "<admin password>"
}
```

Credentials and keys should be set via environment or a secrets-managed config before deploying. The `PG_KEY` env var is used in docker-compose for the database password.

## Responsibilities

- **Auth** — single admin account defined in config.json. Login returns a JWT used by the frontend for all write operations.
- **File API** — CRUD operations on files under `/app/root`. The frontend editor uses these endpoints to create, update, and delete markdown pages and Vue components.
- **User management** — `/admin/users` endpoint (proxied by nginx) for managing accounts stored in PostgreSQL.

## Database

PostgreSQL 17 (`database` service). Stores user accounts. The `pgdata` named volume persists data across container restarts. Connection string is set in `config.json`.

## Notes

This service is intentionally simple and stable — it has not needed significant changes since initial setup. Avoid adding complexity here unless strictly necessary. New content features should live in the frontend or root content layer instead.
