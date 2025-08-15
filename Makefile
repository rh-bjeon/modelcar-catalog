# Default registry and image prefix
REGISTRY = quay.io/redhat-ai-services
IMAGE_PREFIX = modelcar-catalog
MODELCAR_IMAGES = ./modelcar-images

# # Environment variable for Hugging Face token (must be set)
# ifndef HF_TOKEN
# $(error HF_TOKEN is not set)
# endif

.PHONY: build download push build-and-push build-and-push-all

build:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make build folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	if [ -f "$(folder)/downloader.env" ]; then \
		$(MAKE) download folder=$(folder); \
	fi; \
	tag=$$(basename "$(folder)"); \
	image=$(REGISTRY)/$(IMAGE_PREFIX):$$tag; \
	echo "Building image with tag $$image"; \
	build_cmd="podman build $(folder) -t $$image --platform linux/amd64"; \
	if [ -n "$(HF_TOKEN)" ]; then \
		build_cmd="$$build_cmd --build-arg HF_TOKEN=$(HF_TOKEN)"; \
	fi; \
	echo "Executing: $$build_cmd"; \
	eval $$build_cmd

download:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make download folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	mkdir -p $(folder)/models; \

	download_cmd="podman run --rm --platform linux/amd64 \
	-v ./$(folder)/models:/models \
	--env-file $(folder)/downloader.env"; \

	if [ -n "$(HF_TOKEN)" ]; then \
		download_cmd="$$download_cmd -e HF_TOKEN=$(HF_TOKEN)"; \
	fi; \

	download_cmd="$$download_cmd $(REGISTRY)/huggingface-downloader:latest"; \
	eval $$download_cmd

date-tag:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make push folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	tag=$$(basename "$(folder)"); \
	date-tag=$$(date -u +'%Y%m%dt%H%Mz'); \
	echo "Date tag: $$date-tag"; \
	echo "Tag: $$tag"; \
	podman tag $(REGISTRY)/$(IMAGE_PREFIX):$$tag $(REGISTRY)/$(IMAGE_PREFIX):$${tag}-$${date-tag}

push:
	@if [ -z "$(folder)" ]; then \
		echo "Usage: make push folder=<path-to-folder>"; \
		exit 1; \
	fi; \
	baseTag=$$(basename "$(folder)"); \
	imageID=$$(podman images --filter "reference=$(REGISTRY)/$(IMAGE_PREFIX):$$baseTag" --format "{{.ID}}"); \
	echo "Image ID: $$imageID"; \
	tags=$$(podman images --filter "id=$$imageID" --format "{{.Repository}}:{{.Tag}}"); \
	echo "Tags: $$tags"; \
	for tag in $$tags; do \
		echo "Pushing image with tag $$tag"; \
		podman push $(REGISTRY)/$(IMAGE_PREFIX):$$tag; \
	done

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

clean-all:
	rm -rf $(MODELCAR_IMAGES)/*/models

build-and-push-all: $(MODELCAR_IMAGES)/*
	for folder in $^ ; do \
		$(MAKE) build-and-push folder=$${folder}; \
		$(MAKE) prune folder=$${folder}; \
	done
