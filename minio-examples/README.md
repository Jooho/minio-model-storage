# Models MinIO Examples
This provides MinIO-based model storage docker image contains example models. Loopy use this repository to deploy sample models most times.
To use this repo, you need to use `git lfs`

## Pre requirement
```sh
sudo yum install git git-lfs podman -y
```

## Build the image

```sh
make build
```

## Push the image

```shell
make push
```

## Start the container

Start a "modelmesh-minio-examples" container:

```sh
podman run --rm --name "model-minio" \
  -u "1000" \
  -p "9000:9000" \
  -p "9001:9001" \
  -e "MINIO_ACCESS_KEY=admin" \
  -e "MINIO_SECRET_KEY=password" \
  quay.io/jooholee/models-minio:latest server /data1
```

## Test the image using the MinIO client
Install the [MinIO client](https://min.io/docs/minio/linux/reference/minio-mc.html#quickstart), `mc`.

Create an alias `localminio` for an local instance:

```sh
mc alias set localminio http://localhost:9000 admin password
```

List objects in the instance's bucket:

```sh
mc ls -r localminio/example-models
```

### Stop and remove the docker container

To shut down the "model-minio" container run the following
commands:

```sh
podman stop "model-minio"
podman rm "model-minio"
```

