# Default registry and image prefix
REGISTRY = quay.io/redhat-ai-services
IMAGE_PREFIX = modelcar-catalog
MODELCAR_IMAGES = ./modelcar-images

# # Environment variable for Hugging Face token (must be set)
# ifndef HF_TOKEN
# $(error HF_TOKEN is not set)
# endif

.PHONY: build push build-and-push build-and-push-all

build:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make build folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	tag=$$(basename "$(folder)"); \
	image=$(REGISTRY)/$(IMAGE_PREFIX):$$tag; \
	echo "Building image with tag $$image"; \
	if [ -n "$(HF_TOKEN)" ]; then \
		podman build $(folder) \
			-t $$image \
			--build-arg HF_TOKEN=$(HF_TOKEN) \
			--platform linux/amd64; \
	else \
		podman build $(folder) \
			-t $$image \
			--platform linux/amd64; \
	fi

push:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make push folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	tag=$$(basename "$(folder)"); \
	echo "Pushing image with tag $$tag"; \
	podman push $(REGISTRY)/$(IMAGE_PREFIX):$$tag

build-and-push:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make build-and-push folder=<folder-name>"; \
		exit 1; \
	fi; \
	$(MAKE) build folder=$(folder)
	$(MAKE) push folder=$(folder)

prune:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make prune folder=<folder-name>"; \
		exit 1; \
	fi; \
	podman image prune --force; \
	tag=$$(basename "$(folder)"); \
	image=$(REGISTRY)/$(IMAGE_PREFIX):$${tag}; \
	podman image rm $$image;

build-and-push-all: $(MODELCAR_IMAGES)/*
	for folder in $^ ; do \
		$(MAKE) build-and-push folder=$${folder}; \
		$(MAKE) prune folder=$${folder}; \
	done
