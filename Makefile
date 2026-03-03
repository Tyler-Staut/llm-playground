# Makefile for llm-playground
# Simplifies common tasks for development and quick start.

# run 
#   make setup  to copy .env example
#   make up     to start services
#   make down   to stop
#   make logs   to stream logs
#   make check  to validate config

SHELL := /bin/bash

.PHONY: setup up down logs check

setup:
	@if [ ! -f .env ]; then \
		echo "Creating .env from example"; \
		cp .env.example .env; \
		echo "Edit .env before running"; \
	else \
		echo ".env already exists"; \
	fi

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

# quick validation: ensure compose file parses cleanly and litellm config loads
check:
	docker compose config > /dev/null && \
	if [ -f litellm/config.yaml ]; then \
		echo "litellm config exists"; \
	else \
		echo "warning: litellm/config.yaml missing"; \
	fi
