#!/bin/bash

# This script creates a Kubernetes secret for cloudflared credentials
# Replace 'your-credentials-file.json' with the actual path to your downloaded credentials file

echo "Creating cloudflared credentials secret..."
kubectl create secret generic cloudflared-creds \
  --from-file=credentials.json=your-credentials-file.json \
  --namespace=homelab

echo "Secret created successfully!"
echo "Now update the ConfigMap with your tunnel ID and apply the deployment." 