# openvino (age-gender-recognition)

## Directory format
  ```
  $MODEL_NAME/$VERSION/FILES
  openvino-age-gender-recognition/1/*bin,*xml         
  ```
  
## minio
- image: quay.io/jooholee/model-minio:latest
- path: openvino/age-gender-recognition

## Model  
- [age-gender-recognition](https://github.com/openvinotoolkit/model_server/tree/main/demos/age_gender_recognition/python)

This model inference age and gender.


## Tutorial

**0.Clone repo**

~~~
git clone https://github.com/Jooho/AIML_sandbox
cd AIML_sandbox/minio-examples/docs/openvino/age-gender-reconition
~~~

**1.Setup loopy**

Please refer [this doc](../loopy-setup.md)

**2.Deploy minio**

~~~
loopy roles run minio-deploy -i cluster_info.sh
~~~

**3.Deploy model with openvino**
~~~
oc new-project openvino-test
# With these label, you can see this namespace with ODH dashboard
oc label ns/openvino-test modelmesh-enabled="false"   opendatahub.io/dashboard="true"

oc process -n opendatahub kserve-ovms |oc create -n openvino-test -f -

oc create -f ./data-connection.yaml

oc create -f ./isvc.yaml

pip install -r requirements.txt
~~~

**4.Check input format**
~~~
# using port-forward
oc project openvino-test
oc port-forward deployment/openvino-predictor-00001-deployment 8888:8888 &
curl http://localhost:8888/v2/models/openvino
# using route
#curl -k https://openvino-test$OPENSHIFT_DOMAIN/v2/models/openvino

{"name":"openvino","versions":["1"],"platform":"OpenVINO","inputs":[{"name":"data","datatype":"FP32","shape":[1,3,62,62]}],"outputs":[{"name":"age_conv3","datatype":"FP32","shape":[1,1,1,1]},{"name":"prob","datatype":"FP32","shape":[1,2,1,1]}]}
~~~

**5.Generate input data**
~~~
python ./convert_image.py
~~~

**6.Send input data**
~~~
curl -XPOST -d @age_gender_recognition_input_request.json  http://localhost:8888/v2/models/openvino/infer

# using route
# curl -XPOST -d @updated_request.json -k https://openvino-test.$OPENSHIFT_DOMAIN/v2/models/openvino/infer

~~~

**Output**
~~~
{
    "model_name": "openvino",
    "model_version": "1",
    "outputs": [{
            "name": "age_conv3",
            "shape": [1, 1, 1, 1],
            "datatype": "FP32",
            "data": [0.32149043679237368]   #age 32
        }, {
            "name": "prob",
            "shape": [1, 2, 1, 1],
            "datatype": "FP32",
            "data": [0.5139618515968323, 0.48603808879852297]    # female -> 51% /male -> 48%
        }]
}
~~~
