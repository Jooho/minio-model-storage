# KServe Installation 

Before you follow this doc, please read [Setup Loopy](./loopy-setup.md)

## OpenDataHub KServe

**Serverless**
~~~
loopy playbooks run odh-fast-install-kserve-serverless-on-existing-cluster -i ./cluster_info.sh -p ENABLE_DASHBOARD=Managed
~~~

**Raw**
~~~
loopy playbooks run odh-fast-install-kserve-raw-on-existing-cluster -i ./cluster_info.sh -p ENABLE_DASHBOARD=Managed
~~~
