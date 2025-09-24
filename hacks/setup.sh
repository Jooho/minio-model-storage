#!/bin/bash
set -x
bucket_name=${1:-latest}
# Wait for MinIO server starting
sleep 10

# Create Minio client
mc alias set myminio http://localhost:9000 minioadmin minioadmin 

# Process command line arguments for optional buckets
if [[ z${bucket_name} != z ]] ;then
    case "$bucket_name" in
        "latest")
            echo "Creating and uploading to example-models bucket..."
            # Create example-models bucket (always included)
            mc mb myminio/example-models
            # Model upload for example-models (always included)
            mc cp --recursive /tmp/models/serving myminio/example-models
            ;;
        "ods-ci-s3")
            echo "Creating and uploading to ods-ci-s3 bucket..."
            mc mb myminio/ods-ci-s3
            mc cp --recursive /tmp/models/ods-ci-s3/ myminio/ods-ci-s3
            ;;
        "ods-ci-wisdom")
            echo "Creating and uploading to ods-ci-wisdom bucket..."
            mc mb myminio/ods-ci-wisdom
            mc cp --recursive /tmp/models/ods-ci-wisdom/ myminio/ods-ci-wisdom
            ;;
        *)
            echo "Warning: Unknown bucket '$bucket' ignored. Supported buckets: ods-ci-s3, ods-ci-wisdom"
            ;;
    esac
fi
rm -rf /data1/.minio.sys/tmp
