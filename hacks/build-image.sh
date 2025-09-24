#!/bin/bash

# Set variables
ENGINE=$1
FINAL_MINIO_IMG=$2
BUCKET_NAME=$3
PLATFORMS=${4:-"linux/amd64,linux/arm64,linux/ppc64le"}
BASE_MINIO_IMG="quay.io/jooholee/model-minio:copy"
INTRIM_MINIO_IMG="quay.io/jooholee/model-minio:intrim"
CONTAINER_NAME="minio-setup-container"
MINIO_ROOT_USER="minioadmin"
MINIO_ROOT_PASSWORD="minioadmin"
echo ${FINAL_MINIO_IMG}
echo ${BUCKET_NAME}

# Build Minio Images

$ENGINE build -t ${BASE_MINIO_IMG} -f Dockerfile.copy .

# Run container in detached mode with root user to fix permissions
$ENGINE rm $CONTAINER_NAME --force
$ENGINE run --privileged --rm -d -v ./models:/tmp/models:rw --name $CONTAINER_NAME -e MINIO_ROOT_USER=$MINIO_ROOT_USER -e MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD --user 1000:0 $BASE_MINIO_IMG server /data_tmp
# $ENGINE run --replace --privileged --rm -d -v ./models:/tmp/models:rw --name $CONTAINER_NAME -e MINIO_ROOT_USER=$MINIO_ROOT_USER -e MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD $BASE_MINIO_IMG server /data1

# Execute setup script inside the container
sleep 20 # Wait for MinIO server to start
$ENGINE exec $CONTAINER_NAME /usr/bin/setup.sh

$ENGINE exec --user root $CONTAINER_NAME chmod 777 -R /data1

# Commit the container to create the interim image
$ENGINE commit $CONTAINER_NAME $INTRIM_MINIO_IMG

# Push interim image to registry for multi-arch build
$ENGINE push $INTRIM_MINIO_IMG

# Clean up intermediate container and temporary files
$ENGINE rm $CONTAINER_NAME --force

echo "Platforms: ${PLATFORMS}"
$ENGINE buildx create --name multiarch-builder --driver docker-container --use 2>/dev/null || $ENGINE buildx use multiarch-builder
$ENGINE buildx build --platform ${PLATFORMS} --push -f Dockerfile -t ${FINAL_MINIO_IMG} .
