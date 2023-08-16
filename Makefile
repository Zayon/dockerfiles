define docker_build_and_push
	docker buildx build \
		--push \
		-t "zayon/$1:$(if $2,$2,$(TAG))" \
		./$1
endef

define docker_build
	docker buildx build \
		-t "zayon/$1:$(if $2,$2,$(TAG))" \
		./$1
endef

.PHONY: build-tiddly-pwa
build-tiddly-pwa: ## Build tiddly-pwa docker image
	$(call docker_build,tiddly-pwa,local)

.PHONY: push-tiddly-pwa
push-tiddly-pwa: ## Push tiddly-pwa docker image, use TAG=latest to push to latest
	$(call docker_build_and_push,tiddly-pwa)

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
