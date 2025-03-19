# Models MinIO Examples
This provides MinIO-based model storage docker image contains example models. Loopy use this repository to deploy sample models most times.
To use this repo, you need to use `git lfs`

## Pre requirement
```sh
sudo yum install git git-lfs podman -y
git lfs install
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
podman run --privileged --rm --name "model-minio" \
  -u "1000" \
  -p "9000:9000" \
  -p "9001:9001" \
  -e "MINIO_ROOT_USER=admin" \
  -e "MINIO_ROOT_PASSWORD=password" \
  quay.io/jooholee/model-minio:latest server --console-address=":9001" /data1
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

