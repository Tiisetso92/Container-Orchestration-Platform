#!/bin/bash

echo "Applying Kubernetes configurations..."
oc apply -f ../kubernetes/deployment.yaml

echo "Deployment complete."


