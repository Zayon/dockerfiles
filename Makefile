define docker_build_and_push
	$(eval export PUSH=--push) $(call docker_build,$1,$2)
endef

define docker_build_local
	$(eval export ADDITIONAL_TAG=-t "zayon/$1:local" ) $(call docker_build,$1,$2)
endef

define docker_build
	docker buildx build \
		$(PUSH) \
		-t "zayon/$1:latest" \
		-t "zayon/$1:$2" \
		$(ADDITIONAL_TAG) \
		$(ADDITIONAL_BUILD_ARGS) \
		./$1
endef

## [Tiddly PWA]
.PHONY: build-tiddly-pwa
## Build tiddly-pwa docker image, use TAG=x.x.x to define tiddly-pwa version
build-tiddly-pwa:
	$(eval export ADDITIONAL_BUILD_ARGS=--build-arg TIDDLY_PWA_VERSION="$(TAG)") \
	$(call docker_build_local,tiddly-pwa,$(TAG))

.PHONY: push-tiddly-pwa
## Push tiddly-pwa docker image, use TAG=x.x.x to define tiddly-pwa version
push-tiddly-pwa:
	$(eval export ADDITIONAL_BUILD_ARGS=--build-arg TIDDLY_PWA_VERSION="$(TAG)") \
	$(call docker_build_and_push,tiddly-pwa,$(TAG))

## [Ansible]
.PHONY: build-ansible
## Build ansible docker image
build-ansible:
	$(call docker_build_local,ansible,latest)

.PHONY: push-ansible
## Push ansible docker image
push-ansible:
	$(call docker_build_and_push,ansible,latest)

.DEFAULT_GOAL := help
.PHONY: help

# Help target to display available targets and their descriptions.
help:
	@echo "Usage: make [target] [VARIABLE=value]"
	@echo ""
	@echo "Available targets:"
	@awk '/^## \[.*\]/ { section = substr($$0, 5, length($$0) - 5); hasSection = 1 } \
		/^[a-zA-Z\-_0-9]+:/ { \
			helpMessage = match(lastLine, /^## (.*)/); \
			if (helpMessage) { \
				target = $$1; \
				description = substr(lastLine, RSTART + 3, RLENGTH - 3); \
				if (hasSection) { \
					printf "\n \033[1;34m[%s]\033[0m\n", section; \
					hasSection = 0; \
				} \
				printf "  \033[36m%-20s\033[0m %s\n", target, description; \
			} \
		} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

