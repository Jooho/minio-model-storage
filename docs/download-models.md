# Download Models

To download these models, you will need AWS credentials. Please contact the team to obtain the necessary AWS access key and secret key for authentication.

**Download commands**
```
s3cmd get s3://ods-ci-s3/mnist-8.onnx
s3cmd get s3://ods-ci-s3/test-dir --recursive
s3cmd get s3://ods-ci-s3/vehicle-detection --recursive
s3cmd get s3://ods-ci-s3/vehicle-detection-kserve --recursive

s3cmd get s3://ods-ci-wisdom/dog_breed_classification --recursive
s3cmd get s3://ods-ci-wisdom/flan-t5-small --recursive
s3cmd get s3://ods-ci-wisdom/granite-8b-code-base --recursive
```

**Folder Structure**

```
ods-ci-s3
├── test-dir
│   └── 1
├── vehicle-detection
└── vehicle-detection-kserve
    └── 1
ods-ci-wisdom
├── dog_breed_classification
│   └── 1
├── flan-t5-small
│   ├── flan-t5-small-caikit
│   │   └── artifacts
│   └── flan-t5-small-hf
└── granite-8b-code-base
```
