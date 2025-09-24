# Container Engine and Base Image
ENGINE ?= docker
BASE_IMG = quay.io/jooholee/model-minio
TAG ?= latest

# Tag Mappings(Bucket)
TAGS_MAP_s3 = ods-ci-s3
TAGS_MAP_wisdom = ods-ci-wisdom
TAGS_MAP_latest = example-models

# Full image helper (indirect reference)
define FULL_IMAGE
$(BASE_IMG):$(TAGS_MAP_$(1))
endef

# Generalized build target
.PHONY: build-%  # e.g., build-s3 or build-wisdom
build-%:
	./hacks/build-image.sh $(ENGINE) $(BASE_IMG):$(TAGS_MAP_$*) "$(TAGS_MAP_$*)"

# Default build (uses TAG)
.PHONY: build
build:
	./hacks/build-image.sh $(ENGINE) $(BASE_IMG):$(TAG) "$(TAGS_MAP_latest)"

# Generalized push target
.PHONY: push-%
push-%:
	$(ENGINE) tag $(BASE_IMG):$(TAGS_MAP_$*) $(BASE_IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(BASE_IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(BASE_IMG):$(TAGS_MAP_$*)

# Default push (uses TAG)
.PHONY: push
push:
	$(ENGINE) tag $(BASE_IMG):$(TAG) $(BASE_IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(BASE_IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(BASE_IMG):$(TAG)
