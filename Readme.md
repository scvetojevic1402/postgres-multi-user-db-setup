## Project Overview

This project demonstrates the setup of a PostgreSQL database with additional extensions and initialization using a custom script. It also illustrates the use of environment variables for configuring the database and user credentials. In this example, the database is initialized with the `postgis`, `pgrouting`, and `vector` extensions, along with a user and database for another service (e.g. `Keycloak`). Docker and Docker Compose are utilized to manage the environment.

## Usage

1. **Create your own .env file**:
    Copy the `.env.example` file and rename it to `.env`. Update the environment variables with your own values.
    ```sh
    cp .env.example .env
    ```
2. **Build and Start Containers**:
   ```sh
   make run
   ```
   
## Files and Directories

- `Makefile`: Contains commands to build, run, stop, and manage Docker containers.
- `Dockerfile`: Defines the Docker image with PostgreSQL and required extensions.
- `init-scripts/initdb.sh`: Script to initialize the database with required extensions and create a user and database.
- `.env`: Environment variables for database and user configuration.

## Makefile Target

- `run`: Builds Docker images, prunes the system, and starts containers.

## Dockerfile

- **Base Image**: `postgres:16.6-bullseye`
- **Dependencies**: Installs `postgresql-16-postgis-3`, `postgresql-16-pgrouting`, and `postgresql-16-pgvector`.
- **Initialization**: Copies `.env` and `initdb.sh` to the Docker entrypoint directory and makes `initdb.sh` executable.

## Initialization Script (`initdb.sh`)

- Loads environment variables from `.env`.
- Initializes the database with the specified user and password.
- Installs the `postgis`, `pgrouting`, and `vector` extensions.
- Creates a user and database for Keycloak.

## Environment Variables

- `POSTGRES_DB`: Name of the PostgreSQL database.
- `POSTGRES_USER`: PostgreSQL user.
- `POSTGRES_PASSWORD`: Password for the PostgreSQL user.
- `KC_USER`: Keycloak user.
- `KC_PASSWORD`: Password for the Keycloak user.
- `KC_DB`: Keycloak database name.