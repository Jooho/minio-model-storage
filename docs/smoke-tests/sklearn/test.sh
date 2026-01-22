kind create cluster

curl -s "https://raw.githubusercontent.com/kserve/kserve/master/hack/setup/quick-install/kserve-standard-mode-full-install-with-manifests.sh" | bash

kubectl create ns sklearn-test
kubectl apply -f servingruntime.yaml -n sklearn-test
kubectl apply -f sa.yaml -n sklearn-test
kubectl apply -f storage-config.yaml -n sklearn-test
kubectl apply -f isvc.yaml -n sklearn-test

kubectl wait --for=condition=ready pod -l component=predictor -n sklearn-test --timeout 150s 

pod_name=$(kubectl get pod -l app=isvc.sklearn-iris-predictor --no-headers -o name)
kubectl port-forward ${pod_name} 8082:8080 &

curl -s -X POST http://localhost:8082/v2/models/sklearn-iris/infer \
  -H "Content-Type: application/json" \
  -d '{
        "inputs": [
          {
            "name": "input-0",
            "shape": [2, 4],
            "datatype": "FP32",
            "data": [
              [6.8, 2.8, 4.8, 1.4],
              [6.0, 3.4, 4.5, 1.6]
            ]
          }
        ]
      }'

fg

