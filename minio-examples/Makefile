# Container Engine to be used for building images
ENGINE ?= "podman"
TAG ?= "latest"
#IMG=quay.io/jooholee/modelmesh-minio-examples:${TAG}
IMG=quay.io/jooholee/model-minio:${TAG}

test:
	@echo $(IMG)

build: 
	./hacks/build-image.sh $(ENGINE) $(IMG)

push:
	$(ENGINE) push $(IMG) 

all: build push
