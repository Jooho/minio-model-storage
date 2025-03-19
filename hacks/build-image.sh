#!/bin/bash

# Set variables
ENGINE=$1
FINAL_MINIO_IMG=$2
BASE_MINIO_IMG="quay.io/jooholee/model-minio:copy"
CONTAINER_NAME="minio-setup-container"
MINIO_ROOT_USER="minioadmin"
MINIO_ROOT_PASSWORD="minioadmin"

# Build Minio Images
$ENGINE build -t ${BASE_MINIO_IMG} .

# Run container in detached mode
$ENGINE run --replace --privileged --rm -d -v ./models:/tmp/models:rw --name $CONTAINER_NAME -e MINIO_ROOT_USER=$MINIO_ROOT_USER -e MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD $BASE_MINIO_IMG server /data1

# Execute setup script inside the container
sleep 20 # Wait for MinIO server to start
$ENGINE exec $CONTAINER_NAME /usr/bin/setup.sh

# Commit the container to create the final image
$ENGINE commit $CONTAINER_NAME $FINAL_MINIO_IMG

# Clean up intermediate container
$ENGINE rm $CONTAINER_NAME --force
