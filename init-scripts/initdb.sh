#!/bin/bash
set -e

# Load environment variables from .env file
if [ -f /docker-entrypoint-initdb.d/.env ]; then
    export $(cat /docker-entrypoint-initdb.d/.env | grep -v '#' | awk '/=/ {print $1}')
fi

echo "================> Initializing database: $POSTGRES_DB"
echo "================> User: $POSTGRES_USER"
echo "================> Password: $POSTGRES_PASSWORD"
echo "================> Keycloak User: $KC_USER"
echo "================> Keycloak Password: $KC_PASSWORD"

# Install additional extensions in the keycloak database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Enable PostGIS
    CREATE EXTENSION IF NOT EXISTS postgis;
    
    -- Enable PgRouting
    CREATE EXTENSION IF NOT EXISTS pgrouting;
    
    -- Enable pgVector
    CREATE EXTENSION IF NOT EXISTS vector;

    -- Create user and database
    CREATE USER "$KC_USER" WITH PASSWORD '$KC_PASSWORD';
    CREATE DATABASE "$KC_DB" OWNER "$KC_USER";
EOSQL