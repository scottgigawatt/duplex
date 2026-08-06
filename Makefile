#
# Copyright 2025-2026 Scott Gigawatt
#
# Licensed under the Apache License, Version 2.0.
#
# Makefile: Validate, inspect, and operate the primary Duplex stack and its
#           optional one-shot maintenance charts.
#

#
# Makefile target names.
#
ALL=all
BUILD_DEPENDS=build-depends
CHECK_ENV=check-env
CONFIG=config
CONFIG_EXAMPLE=config-example
DOWN=down
HELP=help
LOGS=logs
OVERLAY_RESET_CONFIG=overlay-reset-config
OVERLAY_RESET_RUN=overlay-reset-run
PULL=pull
UP=up
VALIDATE=validate
WATCHTOWER_CONFIG=watchtower-config
WATCHTOWER_RUN=watchtower-run

TARGETS= \
	$(ALL) \
	$(BUILD_DEPENDS) \
	$(CHECK_ENV) \
	$(CONFIG) \
	$(CONFIG_EXAMPLE) \
	$(DOWN) \
	$(HELP) \
	$(LOGS) \
	$(OVERLAY_RESET_CONFIG) \
	$(OVERLAY_RESET_RUN) \
	$(PULL) \
	$(UP) \
	$(VALIDATE) \
	$(WATCHTOWER_CONFIG) \
	$(WATCHTOWER_RUN)

#
# Docker Compose files and environment files.
#
COMPOSE_FILE ?= docker-compose.yml
ENV_FILE ?= .env
EXAMPLE_ENV_FILE ?= example.env
OVERLAY_RESET_COMPOSE_FILE ?= config/overlay-reset/docker-compose.yml
OVERLAY_RESET_ENV_FILE ?= config/overlay-reset/.env
OVERLAY_RESET_EXAMPLE_ENV_FILE ?= config/overlay-reset/example.env
WATCHTOWER_COMPOSE_FILE ?= config/watchtower/docker-compose.yml
WATCHTOWER_ENV_FILE ?= config/watchtower/.env
WATCHTOWER_EXAMPLE_ENV_FILE ?= config/watchtower/example.env

#
# Docker Compose runtime options.
#
COMPOSE_UP_OPTIONS ?= --detach --pull always --remove-orphans
COMPOSE_DOWN_OPTIONS ?= --remove-orphans --timeout 30
COMPOSE_LOGS_OPTIONS ?= --follow

#
# Docker Compose command compatible with the v2 plugin and legacy v1 binary.
#
DOCKER_COMPOSE := $(shell \
	if docker compose version >/dev/null 2>&1; then \
		echo "docker compose"; \
	elif command -v docker-compose >/dev/null 2>&1; then \
		echo "docker-compose"; \
	else \
		echo ""; \
	fi)

#
# Help line formatting function.
#
define help_line
	@printf "  %-24s %s\n" "$(1)" "$(2)"
endef

#
# Targets that are not files and must run whenever requested.
#
.PHONY: $(TARGETS)

#
# $(ALL): Default target. Start the primary Duplex stack.
#
# Dependencies:
#   $(UP) - Pull and start the primary stack.
#
$(ALL): $(UP)

#
# $(BUILD_DEPENDS): Ensure Docker Compose is available.
#
$(BUILD_DEPENDS):
	@if [ -z "$(DOCKER_COMPOSE)" ]; then \
		echo "Docker Compose is not available."; \
		echo "Install the Docker Compose plugin or docker-compose binary."; \
		exit 1; \
	fi
	@$(DOCKER_COMPOSE) version >/dev/null

#
# $(CHECK_ENV): Ensure the primary private environment file exists.
#
$(CHECK_ENV):
	@if [ ! -f "$(ENV_FILE)" ]; then \
		echo "No $(ENV_FILE) found."; \
		echo "Copy $(EXAMPLE_ENV_FILE) to $(ENV_FILE), then replace placeholders."; \
		echo "Run: cp $(EXAMPLE_ENV_FILE) $(ENV_FILE)"; \
		exit 1; \
	fi

#
# $(CONFIG): Render the primary stack with private deployment settings.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#   $(CHECK_ENV) - Ensure the private environment file exists.
#
$(CONFIG): $(BUILD_DEPENDS) $(CHECK_ENV)
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) -f $(COMPOSE_FILE) config

#
# $(CONFIG_EXAMPLE): Validate the primary stack with safe checked-in defaults.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#
$(CONFIG_EXAMPLE): $(BUILD_DEPENDS)
	$(DOCKER_COMPOSE) --env-file $(EXAMPLE_ENV_FILE) -f $(COMPOSE_FILE) config --quiet

#
# $(UP): Pull and start the primary stack.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#   $(CHECK_ENV) - Ensure the private environment file exists.
#
$(UP): $(BUILD_DEPENDS) $(CHECK_ENV)
	@echo "Rolling the Duplex opening credits. 📺"
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) -f $(COMPOSE_FILE) up $(COMPOSE_UP_OPTIONS)

#
# $(DOWN): Stop and remove the primary stack containers and network.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#   $(CHECK_ENV) - Ensure the private environment file exists.
#
$(DOWN): $(BUILD_DEPENDS) $(CHECK_ENV)
	@echo "Cut. That is a wrap for the Duplex stack. 🎬"
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) -f $(COMPOSE_FILE) down $(COMPOSE_DOWN_OPTIONS)

#
# $(PULL): Pull the image references selected in the private environment file.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#   $(CHECK_ENV) - Ensure the private environment file exists.
#
$(PULL): $(BUILD_DEPENDS) $(CHECK_ENV)
	@echo "Fetching the latest approved cast list. 📦"
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) -f $(COMPOSE_FILE) pull

#
# $(LOGS): Follow logs from the primary stack.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#   $(CHECK_ENV) - Ensure the private environment file exists.
#
$(LOGS): $(BUILD_DEPENDS) $(CHECK_ENV)
	$(DOCKER_COMPOSE) --env-file $(ENV_FILE) -f $(COMPOSE_FILE) logs $(COMPOSE_LOGS_OPTIONS)

#
# $(OVERLAY_RESET_CONFIG): Validate Overlay Reset with safe dry-run defaults.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#
$(OVERLAY_RESET_CONFIG): $(BUILD_DEPENDS)
	$(DOCKER_COMPOSE) \
		--env-file $(OVERLAY_RESET_EXAMPLE_ENV_FILE) \
		-f $(OVERLAY_RESET_COMPOSE_FILE) \
		config --quiet

#
# $(OVERLAY_RESET_RUN): Run one explicitly configured Overlay Reset recovery.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#
$(OVERLAY_RESET_RUN): $(BUILD_DEPENDS)
	@if [ ! -f "$(OVERLAY_RESET_ENV_FILE)" ]; then \
		echo "No $(OVERLAY_RESET_ENV_FILE) found."; \
		echo "Copy $(OVERLAY_RESET_EXAMPLE_ENV_FILE), then review DRY_RUN first."; \
		exit 1; \
	fi
	$(DOCKER_COMPOSE) \
		--env-file $(OVERLAY_RESET_ENV_FILE) \
		-f $(OVERLAY_RESET_COMPOSE_FILE) \
		run --rm overlay-reset

#
# $(WATCHTOWER_CONFIG): Validate one-shot Watchtower with safe defaults.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#
$(WATCHTOWER_CONFIG): $(BUILD_DEPENDS)
	$(DOCKER_COMPOSE) \
		--env-file $(WATCHTOWER_EXAMPLE_ENV_FILE) \
		-f $(WATCHTOWER_COMPOSE_FILE) \
		config --quiet

#
# $(WATCHTOWER_RUN): Run one labeled-container update pass.
#
# Dependencies:
#   $(BUILD_DEPENDS) - Ensure Docker Compose is installed.
#
$(WATCHTOWER_RUN): $(BUILD_DEPENDS)
	@if [ ! -f "$(WATCHTOWER_ENV_FILE)" ]; then \
		echo "No $(WATCHTOWER_ENV_FILE) found."; \
		echo "Copy $(WATCHTOWER_EXAMPLE_ENV_FILE), then review update targets."; \
		exit 1; \
	fi
	$(DOCKER_COMPOSE) \
		--env-file $(WATCHTOWER_ENV_FILE) \
		-f $(WATCHTOWER_COMPOSE_FILE) \
		run --rm watchtower-run

#
# $(VALIDATE): Validate environment parity and every Compose chart.
#
# Dependencies:
#   $(CONFIG_EXAMPLE) - Validate the primary stack.
#   $(OVERLAY_RESET_CONFIG) - Validate the destructive recovery chart safely.
#   $(WATCHTOWER_CONFIG) - Validate the one-shot updater chart safely.
#
$(VALIDATE): $(CONFIG_EXAMPLE) $(OVERLAY_RESET_CONFIG) $(WATCHTOWER_CONFIG)
	test/check-config.sh

#
# $(HELP): Print available targets.
#
$(HELP):
	@echo "Usage: make [TARGET]"
	@echo ""
	@echo "Targets:"
	$(call help_line,$(ALL),Starts the primary Duplex stack.)
	$(call help_line,$(BUILD_DEPENDS),Ensures Docker Compose is installed.)
	$(call help_line,$(CHECK_ENV),Ensures the private .env exists.)
	$(call help_line,$(CONFIG),Renders the primary stack with private settings.)
	$(call help_line,$(CONFIG_EXAMPLE),Validates the primary stack with example settings.)
	$(call help_line,$(UP),Pulls and starts the primary stack.)
	$(call help_line,$(DOWN),Stops and removes the primary stack.)
	$(call help_line,$(PULL),Pulls the configured service images.)
	$(call help_line,$(LOGS),Follows primary stack logs.)
	$(call help_line,$(OVERLAY_RESET_CONFIG),Validates safe Overlay Reset defaults.)
	$(call help_line,$(OVERLAY_RESET_RUN),Runs one configured Overlay Reset.)
	$(call help_line,$(WATCHTOWER_CONFIG),Validates one-shot Watchtower defaults.)
	$(call help_line,$(WATCHTOWER_RUN),Runs one labeled-container update pass.)
	$(call help_line,$(VALIDATE),Validates all checked-in charts and env contracts.)
	$(call help_line,$(HELP),Displays this help message.)
