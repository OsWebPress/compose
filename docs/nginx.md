# Nginx

Runs inside the frontend container (not exposed separately). Listens on port 80, which is the only port mapped to the host (`${HOST_PORT}:80`). Serves both the Vue SPA and root content files, and proxies write operations to the backend.

## Config files

There are two nginx config files:

| File | Used when |
|---|---|
| `frontend/nginx.conf` | Production — baked into the Docker image via `COPY` in the Dockerfile |
| `frontend/nginx.dev.conf` | Local dev — mounted at runtime via `docker-compose.override.yaml`, overrides the image config |

When editing nginx behaviour, **both files usually need the same change**. The override file takes precedence locally, so changes to `nginx.conf` alone will not be visible in local dev.

## Routing Logic

### Favicon
```
location = /favicon.ico
  try_files /app/root/favicon.ico @default_favicon
  @default_favicon → /usr/share/nginx/html/favicon.ico
```
Drop `root/favicon.ico` to override the site favicon with no rebuild required. If the file is absent, nginx falls back to the favicon baked into the Docker image.

### Vue SPA
```
location /
  try_files $uri $uri/ /index.html
```
All unmatched paths fall through to `index.html` so Vue Router handles them client-side.

### Read-only API (always proxied to backend)
```
location ~ ^/api/(ronly/|navigation/active.vue|admin/users)
  → proxy to backend:8080
```
These paths always hit the Rust backend regardless of HTTP method. Used for auth-gated reads and navigation config.

### General API
```
location /api/
  GET  → rewrite to /files/* (served internally from /app/root/)
  POST/PUT/DELETE → proxy to backend:8080
```
GET requests for content are served directly from disk via nginx without hitting the backend. Write operations go through the Rust API.

### Internal file serving
```
location /files/          → alias /app/root/          (internal)
location /files/images/   → alias /app/root/images/   (internal, autoindex on)
```
Both locations are marked `internal` — they cannot be requested directly by clients, only via the rewrite from `/api/` GETs.

## Notes

- `client_max_body_size 32M` — covers image uploads
- File locations set `Cache-Control: public, max-age=900` (15 min) for pages/components and `max-age=3600` (1 hour) for images
- `proxy_no_cache 1` / `proxy_cache_bypass 1` remain on proxy locations (write operations and ronly reads) — only the file-serving GET path is cached
- The backend is reachable inside the Docker network as `backend:8080` but is never exposed to the host
- Gzip is enabled (`gzip on`) for JS, CSS, JSON, XML, and SVG. Production additionally benefits from Brotli via the upstream proxy in front of the server.
