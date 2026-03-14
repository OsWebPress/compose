# Nginx

Runs inside the frontend container (not exposed separately). Listens on port 80, which is the only port mapped to the host (`${HOST_PORT}:80`). Serves both the Vue SPA and root content files, and proxies write operations to the backend.

Config: `frontend/nginx.conf`

## Routing Logic

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
- `proxy_no_cache 1` / `proxy_cache_bypass 1` on all proxy and file locations — caching is intentionally disabled for development; can be enabled per-location for production
- The backend is reachable inside the Docker network as `backend:8080` but is never exposed to the host
