#!/bin/sh
set -x
set -e
bucket_name=${1:-example-models}
# Wait for MinIO server starting
sleep 10

# Create Minio client
export AWS_ACCESS_KEY_ID="admin" 
export AWS_SECRET_ACCESS_KEY="admin" 
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ENDPOINT_URL_S3="http://localhost:8333"

# Process command line arguments for optional buckets
if [[ z${bucket_name} != z ]] ;then
    case "$bucket_name" in
        "example-models")
            echo "Creating and uploading to example-models bucket..."
            # Create example-models bucket (always included)
            aws s3 mb s3://example-models
            # Model upload for example-models (always included)
            aws s3 cp --recursive /tmp/models/serving s3://example-models
            ;;
        "ods-ci-s3")
            echo "Creating and uploading to ods-ci-s3 bucket..."
            aws s3 mb s3://ods-ci-s3
            aws s3 cp --recursive /tmp/models/ods-ci-s3/ s3://ods-ci-s3
            ;;
        "ods-ci-wisdom")
            echo "Creating and uploading to ods-ci-wisdom bucket..."
            aws s3 mb s3://ods-ci-wisdom
            aws s3 cp --recursive /tmp/models/ods-ci-wisdom/ s3://ods-ci-wisdom
            ;;
        *)
            echo "Warning: Unknown bucket '$bucket' ignored. Supported buckets: ods-ci-s3, ods-ci-wisdom"
            ;;
    esac
fi