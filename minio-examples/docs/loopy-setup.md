# Setup loopy

**Setup with source**
- Download loopy and download required cli binary
~~~
git clone https://github.com/Jooho/loopy.git
cd loopy
make init
~~~

**Setup with Loopy Docker Image**
~~~
docker run -it quay.io/jooholee/loopy
~~~

**Create a cluster_info.sh**
~~~
cat cluster_info.sh
CLUSTER_CONSOLE_URL=https://console-openshift-console.XXXX
CLUSTER_API_URL=https://api.XXX:443
CLUSTER_ADMIN_ID=admin
CLUSTER_ADMIN_PW=password
CLUSTER_TOKEN=sha256~XXX   #(OPTIONAL)
CLUSTER_TYPE=ROSA          #(PSI,ROSA)
~~~
