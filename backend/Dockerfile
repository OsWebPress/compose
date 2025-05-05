# ## back3end
# - build the backend
# -> run the production backend

FROM rust:1.86-slim-bookworm AS builder
# Install pkg-config and the OpenSSL development libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev
WORKDIR /app
COPY backend/ /app/
RUN cargo build --release

FROM rust:1.86-slim-bookworm
# RUN apt install -y libstdc++
WORKDIR /app
COPY --from=builder /app/target/release/vault /vault
COPY config.json config.json

# EXPOSE 8081
CMD ["/vault", "config.json"]