#!/usr/bin/env bash

## Complete the following steps to get kubernetes pods running locally

# This is your Docker ID/path
dockerpath=maweeks/devops

# Run the Docker Hub container with kubernetes
kubectl run devops\
    --generator=run-pod/v1\
    --image=$dockerpath\
    --port=80 --labels app=devops

# List kubernetes pods
kubectl get pod

# Forward the container port to a host
kubectl port-forward devops 8000:80