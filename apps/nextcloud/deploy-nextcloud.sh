#!/bin/bash

# Nextcloud Deployment Script
# This script sets up the database and deploys Nextcloud

set -e

echo "🚀 Starting Nextcloud deployment..."

# Step 1: Initialize MariaDB with Nextcloud database
echo "📊 Setting up Nextcloud database..."
kubectl apply -f infrastructure/mariadb-nextcloud-init-job.yaml

# Wait for the job to complete
echo "⏳ Waiting for database initialization to complete..."
kubectl wait --for=condition=complete job/mariadb-nextcloud-init -n homelab --timeout=60s

# Step 2: Deploy Nextcloud infrastructure
echo "🏗️  Deploying Nextcloud infrastructure..."
kubectl apply -f apps/nextcloud/nextcloud-pv.yaml
kubectl apply -f apps/nextcloud/nextcloud-pvc.yaml
kubectl apply -f apps/nextcloud/nextcloud-secret.yaml
kubectl apply -f apps/nextcloud/nextcloud-config.yaml

# Step 3: Deploy Nextcloud application
echo "📱 Deploying Nextcloud application..."
kubectl apply -f apps/nextcloud/nextcloud-deploy.yaml
kubectl apply -f apps/nextcloud/nextcloud-service.yaml

# Step 4: Deploy certificate (if using HTTPS)
echo "🔒 Deploying SSL certificate..."
kubectl apply -f apps/nextcloud/nextcloud-certificate.yaml

# Wait for Nextcloud to be ready
echo "⏳ Waiting for Nextcloud to be ready..."
kubectl wait --for=condition=available deployment/nextcloud -n homelab --timeout=300s

echo "✅ Nextcloud deployment completed successfully!"
echo ""
echo "🌐 Access Nextcloud at:"
echo "   - Local: http://localhost:30084"
echo "   - Public: https://nc.drnull.site"
echo ""
echo "📊 Database setup:"
echo "   - Database: nextcloud"
echo "   - User: hasan (for phpMyAdmin access)"
echo "   - User: nextcloud (for Nextcloud application)" 