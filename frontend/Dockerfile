# ## frontend
# - nginx
# - build the frontend
# - change permissions for nginx hosting
# - change owners for nginx hosting
# -> host nginx

# Stage 1: Build Vue app
FROM node:23-alpine AS builder

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copy project files and install dependencies
COPY press/ /app/

RUN pnpm install
RUN pnpm build-only

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine

# Remove default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx config (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built frontend from builder
COPY --from=builder /app/dist /usr/share/nginx/html
RUN chown nginx:nginx /usr/share/nginx/html
RUN chmod 755 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-c", "/etc/nginx/conf.d/default.conf", "-g", "daemon off;"]
