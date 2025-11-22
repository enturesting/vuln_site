#!/bin/bash

# OWASP Juice Shop - Reset Script
# This script completely resets the Juice Shop environment

set -e

echo "🗑️  Resetting OWASP Juice Shop Environment..."
echo "============================================="

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: docker-compose.yml not found. Please run this script from the juice-shop-local directory."
    exit 1
fi

# Confirm with user
read -p "⚠️  This will remove all containers, networks, and volumes. Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Reset cancelled"
    exit 0
fi

echo "🔄 Stopping containers..."
docker compose down

echo "🗑️  Removing containers, networks, and volumes..."
docker compose down --volumes --remove-orphans

echo "🧹 Cleaning up Docker images (optional)..."
read -p "Remove Juice Shop Docker image as well? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker rmi bkimminich/juice-shop:latest 2>/dev/null || echo "Image not found or already removed"
fi

echo "✅ Environment reset complete!"
echo ""
echo "🚀 To start fresh: ./start.sh"
