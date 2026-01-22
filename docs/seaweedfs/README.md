# Seaweedfs

SeaweedFS is an independent Apache-licensed open source project with its ongoing development made possible entirely thanks to the support of these awesome backers. If you'd like to grow SeaweedFS even stronger, please consider joining our sponsors on Patreon.


- [Home](https://seaweedfs.github.io/)
- [Github](https://github.com/seaweedfs/seaweedfs)
- [Quick Start](https://github.com/seaweedfs/seaweedfs?tab=readme-ov-file#quick-start)

- [Docker image](https://hub.docker.com/r/chrislusf/seaweedfs)

**Deploy a custom seaweedfs**
~~~
kind create cluster
./deploy.sh
~~~ 

**Ports**
~~~
Master UI: http://localhost:9333
Volume Server: http://localhost:9340
Filer UI: http://localhost:8888
S3 Endpoint: http://localhost:8333
WebDAV: http://localhost:7333
Admin UI: http://localhost:23646
~~~


**Useful commands**

- Setup connection for seaweedfs
~~~

kubectl port-forward svc/seaweedfs 23646:23646 8333:8333 &

export AWS_ACCESS_KEY_ID="admin" 
export AWS_SECRET_ACCESS_KEY="admin" 
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ENDPOINT_URL_S3="http://localhost:8333"
~~~

- aws commands
~~~
aws s3 ls
aws s3 cp --recursive ./models s3://mybucket/. --no-verify-ssl
aws s3 mb s3://my-bucket-name  # create bucket
~~~

- console url: http://localhost:23646


## Reference
- [SSL](https://github.com/seaweedfs/seaweedfs/commit/f02e283ad272e9659d95f6255d2512a3e1950445)
