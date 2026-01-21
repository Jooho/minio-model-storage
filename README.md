# Models Seaweedfs Examples
This provides Seaweedfs-based model storage docker image contains example models. Loopy use this repository to deploy sample models most times.
To use this repo, you need to use `git lfs`

## Pre requirement
```sh
sudo yum install git git-lfs podman -y
git lfs install
```


## Build the image

**Pre-requirement**
You should copy models to the right directories.
```
kserve/model models  --> models/serving
ods-ci-s3 models     --> models/ods-ci-s3
ods-ci-wisdom models --> models/ods-ci-wisdom
```
**Build**
```sh
make build
#or
make build-all
```

## Push the image

```shell
make push
#or
make build-all
```

## Start the container

Start a "model-seaweedfs" container:

```sh
podman run --privileged --rm --name "model-seaweedfs" \
  -u "1000" \
  -e "AWS_ACCESS_KEY_ID=admin" \
  -e "AWS_SECRET_ACCESS_KEY=admin" \
  quay.io/jooholee/model-seaweedfs:latest server mini -s3
```

## Test the image using the aws client
Install the aws client.
```
sudo dnf install -y aws
```

Export required env variables for an local instance:

```sh
export AWS_ACCESS_KEY_ID="admin" 
export AWS_SECRET_ACCESS_KEY="admin" 
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ENDPOINT_URL_S3="http://localhost:8333"

```

List objects in the instance's bucket:

```sh
aws s3 ls s3://example-models
```

### Stop and remove the docker container

To shut down the "model-seaweedfs" container run the following
commands:

```sh
podman stop "model-seaweedfs"
podman rm "model-seaweedfs"
```

