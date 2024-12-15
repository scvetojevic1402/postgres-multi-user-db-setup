# Base image with PostgreSQL
FROM postgres:16.6-bullseye

# Install required dependencies
RUN apt-get update && apt-get install -y \
    postgresql-16-postgis-3 \
    postgresql-16-pgrouting \
    postgresql-16-pgvector \
    && rm -rf /var/lib/apt/lists/*

# Create a script to initialize the database with the required extensions
COPY .env /docker-entrypoint-initdb.d/
COPY /init-scripts/initdb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/initdb.sh