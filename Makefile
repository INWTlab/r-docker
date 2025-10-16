R_VERSION := 4.5.1
TAG := ${R_VERSION}
IMAGES := r-base r-batch r-model r-geos r-shiny

.PHONY: update-version
update-version:
	@echo "--- Updating R version tags to ${R_VERSION} in Dockerfiles ---"
	@for image in ${IMAGES}; do \
		file="$$image/Dockerfile"; \
		sed -i "s/\(ARG R_VERSION=\)[0-9]\+\.[0-9]\+\.[0-9]\+/\1${R_VERSION}/g" "$$file" \
		&& echo "Updated $$file"; \
	done
	@echo "--- All Dockerfiles updated successfully! ---"

.PHONY: all $(IMAGES) clean
all: $(IMAGES)
	@echo "--- Successfully built all Docker images with tag: $(TAG) ---"

$(IMAGES):
	@echo "Building Docker image: inwt/$@:$(TAG) from folder: $@"
	docker build -t inwt/$@:$(TAG) $@

.PHONY: clean
clean:
	@echo "Removing locally tagged images for version ${TAG}..."
	@for img in ${ALL_IMAGES}; do \
		docker rmi inwt/$$img:${TAG} || true; \
	done
