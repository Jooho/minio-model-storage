#!/bin/sh

# Wait for MinIO server starting
sleep 10

# Create Minio client
mc alias set myminio http://localhost:9000 minioadmin minioadmin

# Create buckets
mc mb myminio/ods-ci-s3
mc mb myminio/ods-ci-wisdom

# Model upload with mc command
mc cp --recursive /tmp/models/serving myminio/example-models
mc cp --recursive /tmp/models/ods-ci-s3 myminio/ods-ci-s3
mc cp --recursive /tmp/models/ods-ci-wisdom myminio/ods-ci-wisdom

rm -rf /data1/.minio.sys/tmp