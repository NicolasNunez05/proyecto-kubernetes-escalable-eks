.PHONY: help build up down logs clean seed test

# Variables
COMPOSE=docker-compose
BACKEND_CONTAINER=gpuchile_backend
FRONTEND_CONTAINER=gpuchile_frontend
DB_CONTAINER=gpuchile_postgres

help: ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Construye las imágenes
	$(COMPOSE) build

up: ## Levanta todos los servicios
	$(COMPOSE) up -d

down: ## Detiene todos los servicios
	$(COMPOSE) down

logs: ## Muestra logs de todos los servicios
	$(COMPOSE) logs -f

logs-backend: ## Logs del backend
	$(COMPOSE) logs -f backend

logs-frontend: ## Logs del frontend
	$(COMPOSE) logs -f frontend

restart: down up ## Reinicia todos los servicios

clean: ## Limpia containers, volumes y cache
	$(COMPOSE) down -v
	docker system prune -f

seed: ## Ejecuta el seed de datos (solo si backend está corriendo)
	$(COMPOSE) exec backend python -m app.seed_data

shell-backend: ## Shell interactivo en el backend
	$(COMPOSE) exec backend /bin/bash

shell-db: ## Accede a psql
	$(COMPOSE) exec db psql -U postgres -d gpuchile

shell-redis: ## Accede a redis-cli
	$(COMPOSE) exec redis redis-cli -a redis123

test-backend: ## Ejecuta tests del backend
	$(COMPOSE) exec backend pytest

ps: ## Muestra estado de los servicios
	$(COMPOSE) ps

health: ## Verifica salud de los servicios
	@echo "🔍 Verificando servicios..."
	@curl -s http://localhost:8000/health | jq || echo "❌ Backend no responde"
	@curl -s http://localhost:5173 > /dev/null && echo "✅ Frontend OK" || echo "❌ Frontend no responde"

rebuild: clean build up ## Reconstruye todo desde cero
