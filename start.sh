#!/bin/bash

# OWASP Juice Shop - Start Script
# This script starts the Juice Shop application using Docker Compose

set -e

echo "🧃 Starting OWASP Juice Shop..."
echo "================================"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: docker-compose.yml not found. Please run this script from the juice-shop-local directory."
    exit 1
fi

# Pull the latest image
echo "📥 Pulling latest Juice Shop image..."
docker compose pull

# Start the application
echo "🚀 Starting Juice Shop container..."
docker compose up -d

# Wait a moment for the container to start
echo "⏳ Waiting for application to start..."
sleep 5

# Check if the container is running
if docker compose ps | grep -q "juice-shop-app.*running"; then
    echo "✅ Juice Shop is starting up!"
    echo ""
    echo "🌐 Application will be available at: http://localhost:3000"
    echo "⏱️  Please wait 30-60 seconds for full startup"
    echo ""
    echo "📊 To check status: docker compose ps"
    echo "📝 To view logs: docker compose logs -f"
    echo "🛑 To stop: ./stop.sh"
    echo ""
    echo "💡 Run ./health-check.sh to verify when the app is fully ready"
else
    echo "❌ Error: Failed to start Juice Shop container"
    echo "📝 Check logs with: docker compose logs"
    exit 1
fi
