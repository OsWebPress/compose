# OsPress

A self-hosted website builder where markdown files are pages, rendered client-side into Vue components. Content authors write markdown with optional Vue component tags; developers extend the system by adding Vue components and custom makedown tokens.

## Services

| Service | Doc | Role |
|---|---|---|
| Vue frontend | [docs/frontend.md](docs/frontend.md) | SPA, editor, makedown renderer |
| Nginx (frontend) | [docs/nginx.md](docs/nginx.md) | Routes API, serves root files, hosts SPA |
| Rust backend | [docs/backend.md](docs/backend.md) | Auth (JWT), file write API |
| Root content | [docs/root.md](docs/root.md) | Shared volume: pages, components, images |

All services are defined in `docker-compose.yaml`. Both frontend and backend mount `./root` at `/app/root`.

## Key Conventions

- `root/carbon/*.md` are site pages — the URL path maps directly to the filename (`carbon/foo.md` → `site.com/foo`, `carbon/.md` → `site.com/`)
- Vue components in markdown must be PascalCase. Self-closing (`<MyComponent />`) and block (`<MyComponent>...</MyComponent>`) forms are both supported.
- Remote components live in `root/component/`. They are fetched by the client at runtime from `/api/component/Name.vue` and cached in a Pinia store.
- `root/component/makedown/` contains the rendering components for makedown tokens (h1, h2, link, image, etc.) — these are separate from content components.
- Tailwind classes are available inside all remote Vue components.

## Skills

Skills (reusable prompts for common tasks) live in `docs/skills/`. Reference one by name and the relevant file will guide the implementation.

- [new-component](docs/skills/new-component.md) — add a Vue component to `root/component/`
- [new-page](docs/skills/new-page.md) — add a markdown page to `root/carbon/`
- [style-website](docs/skills/style-website.md) — generate a site style guide at `root/style-guide.md`

## Common commands

| Action | Command |
|---|---|
| Rebuild frontend (dev, no cache) | `docker compose up -d --build frontend` |
| Rebuild backend | `docker compose up -d --build backend` |
| Rebuild all (dev) | `docker compose up -d --build` |
| Rebuild all (prod, with caching) | `docker compose -f docker-compose.yaml up -d --build` |

## Basic house rules
- Do not touch git!
- Add an empty newline at the end of files. If you encounter a file without make sure to add this.
