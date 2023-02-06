# Container Engine to be used for building images
ENGINE ?= "podman"
TAG ?= "latest"
IMG=quay.io/jooholee/modelmesh-minio-examples:${TAG}

test:
	@echo $(IMG)

build-minio: 
	$(ENGINE) build -f Dockerfile -t $(IMG) .

push-minio:
	$(ENGINE) push $(IMG) 

