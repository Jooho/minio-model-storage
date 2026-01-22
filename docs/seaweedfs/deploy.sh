#!/bin/bash
kubectl create ns seaweedfs
kubectl config set-context --current --namespace seaweedfs
kubectl apply -f ./deployment.yaml
kubectl apply -f ./svc.yaml
