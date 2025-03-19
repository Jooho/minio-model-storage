#!/bin/sh

# Wait for MinIO server starting
sleep 10

# Create Minio client
mc alias set myminio http://localhost:9000 minioadmin minioadmin

# Model upload with mc command
mc cp --recursive /tmp/models/* myminio/example-models

rm -rf /data1/.minio.sys/tmp