# Define the Docker Compose file
DOCKER_COMPOSE_FILE = docker-compose.yaml

# Define the run target
.PHONY: run
run:
	@echo "Building Docker images and starting containers..."
	docker system prune -af
	docker-compose -f $(DOCKER_COMPOSE_FILE) down
	docker-compose -f $(DOCKER_COMPOSE_FILE) build
	docker-compose -f $(DOCKER_COMPOSE_FILE) up