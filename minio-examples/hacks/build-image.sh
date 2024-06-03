#!/bin/bash

# Set variables
ENGINE=$1
FINAL_MINIO_IMG=$2
BASE_MINIO_IMG="quay.io/jooholee/model-minio:copy"
CONTAINER_NAME="minio-setup-container"
MINIO_ACCESS_KEY="minioadmin"
MINIO_SECRET_KEY="minioadmin"

# Build Minio Images
$ENGINE build -t ${BASE_MINIO_IMG} .

# Run container in detached mode
$ENGINE run --rm -d -v ./models:/tmp/models:rw --name $CONTAINER_NAME -e MINIO_ACCESS_KEY=$MINIO_ACCESS_KEY -e MINIO_SECRET_KEY=$MINIO_SECRET_KEY $BASE_MINIO_IMG server /data1

# Execute setup script inside the container
sleep 20 # Wait for MinIO server to start
$ENGINE exec $CONTAINER_NAME /usr/bin/setup.sh

# Commit the container to create the final image
$ENGINE commit $CONTAINER_NAME $FINAL_MINIO_IMG

# Clean up intermediate container
$ENGINE rm $CONTAINER_NAME --force
