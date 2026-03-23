#!/usr/bin/env bash
set -e

echo "OsPress production setup"
echo "-------------------------"
echo "Press enter to keep the default value shown in brackets."
echo ""

read -p "Project name (used for container names) [ospress]: " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-ospress}

read -p "Host port [80]: " HOST_PORT
HOST_PORT=${HOST_PORT:-80}

read -p "Admin username [admin]: " ADMIN_USER
ADMIN_USER=${ADMIN_USER:-admin}

read -s -p "Admin password: " ADMIN_PASS
echo ""
if [ -z "$ADMIN_PASS" ]; then
  echo "Admin password cannot be empty."
  exit 1
fi

read -s -p "Database password: " PG_KEY
echo ""
if [ -z "$PG_KEY" ]; then
  echo "Database password cannot be empty."
  exit 1
fi

read -s -p "JWT secret (long random string): " JWT_SECRET
echo ""
if [ -z "$JWT_SECRET" ]; then
  echo "JWT secret cannot be empty."
  exit 1
fi

echo ""
echo "Writing config files..."

# .env
cat > .env <<EOF
# .env only used for docker-compose

PROJECT_NAME=${PROJECT_NAME}
HOST_PORT=${HOST_PORT}
PG_KEY=${PG_KEY}

# Do not touch!
VERSION=0.1
EOF

# backend/config.json
cat > backend/config.json <<EOF
{
	"root": "/app/root",
	"database_url": "postgres://dbuser:${PG_KEY}@database:5432/vault_db",
	"jwt_secret": "${JWT_SECRET}",
	"username": "${ADMIN_USER}",
	"password": "${ADMIN_PASS}"
}
EOF

echo "Done. Run: docker compose -f docker-compose.yaml up -d --build"
