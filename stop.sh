#!/bin/bash

# OWASP Juice Shop - Stop Script
# This script stops the Juice Shop application

set -e

echo "🛑 Stopping OWASP Juice Shop..."
echo "==============================="

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: docker-compose.yml not found. Please run this script from the juice-shop-local directory."
    exit 1
fi

# Stop the application
echo "🔄 Stopping Juice Shop container..."
docker compose down

echo "✅ Juice Shop has been stopped"
echo ""
echo "💡 To start again: ./start.sh"
echo "🗑️  To reset everything: ./reset.sh"
