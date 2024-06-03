# Models MinIO Examples

This MinIO Docker image contains example models.

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

To shut down the "modelmesh-minio-examples" docker container run the following
commands:

```sh
docker stop "modelmesh-minio-examples"
docker rm "modelmesh-minio-examples"
```
