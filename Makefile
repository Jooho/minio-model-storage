# Container Engine to be used for building images
ENGINE ?=podman
TAG ?=latest
#IMG=quay.io/jooholee/modelmesh-minio-examples:${TAG}
IMG=quay.io/jooholee/model-minio
FULL_IMG=quay.io/jooholee/model-minio:${TAG}

test:
	@echo $(IMG)

build: 
	./hacks/build-image.sh $(ENGINE) $(IMG)

push:
	$(ENGINE) tag $(FULL_IMG) $(IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(IMG):$(shell date +%Y%m%d)
	$(ENGINE) push $(FULL_IMG)

all: build push
