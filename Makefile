.ONESHELL: 
SHELL := /bin/bash

include ./.env
# -include ./docker.private.env.mk

help: ## show help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build-front: ## build dev frontend
	@echo "################################################################"
	@echo "# BUILD DEV FRONTEND - $(DOCKER_FRONTEND_IMG)"
	@echo "################################################################"
	docker-compose build --no-cache frontend

build-nginx: ## build dev reverse proxy
	@echo "################################################################"
	@echo "# BUILD DEV REVERSE PROXY - $(DOCKER_NGINX_IMG)"
	@echo "################################################################"
	docker-compose build --no-cache nginx

build: build-front build-nginx ## build all dev containers

shell: ## execute shell on dev frontend
	@echo "################################################################"
	@echo "# EXECUTE SHELL ON DEV FRONTEND - $(DOCKER_FRONTEND_IMG)"
	@echo "################################################################"
	docker-compose exec frontend sh


reverse-proxy-shell: ##  execute shell on dev reverse proxy
	@echo "################################################################"
	@echo "# EXECUTE SHELL ON REVERSE PROXY - $(DOCKER_NGINX_IMG)"
	@echo "################################################################"
	docker-compose exec nginx /bash

start: ## start dev instances
	@echo "################################################################"
	@echo "# START ALL"
	@echo "################################################################"
	docker-compose up -d

stop: ## stop dev instances
	@echo "################################################################"
	@echo "# STOP ALL"
	@echo "################################################################"
	docker-compose down

restart: stop start ## restart instances

frontend-logs: ## show dev frontend logs
	@echo "################################################################"
	@echo "# SHOW DEV FRONTEND LOGS - $(DOCKER_FRONTEND_IMG)"
	@echo "################################################################"
	docker-compose logs -f frontend

reverse-proxy-logs: ## show dev frontend logs
	@echo "################################################################"
	@echo "# SHOW DEV REVERSE PROXY LOGS - $(DOCKER_NGINX_IMG)"
	@echo "################################################################"
	docker-compose logs -f nginx

status: ## show dev status (docker ps)
	@echo "################################################################"
	@echo "# SHOW DEV status"
	@echo "################################################################"
	docker-compose ps



