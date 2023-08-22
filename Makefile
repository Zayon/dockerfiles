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

.PHONY: build-tiddly-pwa
build-tiddly-pwa: ## Build tiddly-pwa docker image, use TAG=x.x.x to define tiddly-pwa version
	$(eval export ADDITIONAL_BUILD_ARGS=--build-arg TIDDLY_PWA_VERSION="$(TAG)") \
	$(call docker_build_local,tiddly-pwa,$(TAG))

.PHONY: push-tiddly-pwa
push-tiddly-pwa: ## Push tiddly-pwa docker image, use TAG=x.x.x to define tiddly-pwa version
	$(eval export ADDITIONAL_BUILD_ARGS=--build-arg TIDDLY_PWA_VERSION="$(TAG)") \
	$(call docker_build_and_push,tiddly-pwa,$(TAG))

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
