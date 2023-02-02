# Container Engine to be used for building images
ENGINE ?= "podman"
TAG := "latest"
IMG=quay.io/jooholee/minio-examples:${TAG}

test:
	@echo $(TAG)

build-minio: 
	$(ENGINE) build -f Dockerfile -t $(IMG) .

push-minio:
	$(ENGINE) push $(IMG) 

