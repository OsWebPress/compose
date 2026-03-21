# OsPress

A self-hosted website builder. Markdown files are pages, rendered client-side into Vue components.

## Prerequisites

- Docker + Docker Compose

## Development

Clone and run:

```bash
docker compose up --build
```

The site is available at `http://localhost:8000`. Default admin login: `user` / `pw`.

## Production

Run the setup script to configure credentials, then bring the stack up:

```bash
./setup.sh
docker compose -f docker-compose.yaml up --build
```

The `-f docker-compose.yaml` flag skips the dev override (`docker-compose.override.yaml`) which disables caching. Production uses the main config with response caching enabled.

`setup.sh` will prompt for:
- Project name (used for container names)
- Host port
- Admin username + password
- Database password
- JWT secret

It writes `.env` and `backend/config.json`. Do not commit these files after running setup.

## Configuration files

| File | Purpose |
|---|---|
| `.env` | Docker Compose vars (port, project name, DB password) |
| `backend/config.json` | Backend secrets (JWT, admin credentials, DB URL) |

