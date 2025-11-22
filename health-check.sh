#!/bin/bash

# OWASP Juice Shop - Health Check Script
# This script checks if Juice Shop is running and accessible

set -e

JUICE_SHOP_URL="http://localhost:3000"
MAX_ATTEMPTS=30
ATTEMPT=1

echo "🏥 OWASP Juice Shop Health Check"
echo "================================"
echo "🎯 Target: $JUICE_SHOP_URL"
echo ""

# Function to check if the service is responding
check_service() {
    if command -v curl >/dev/null 2>&1; then
        # Use curl if available
        curl -s -f "$JUICE_SHOP_URL" > /dev/null 2>&1
    elif command -v wget >/dev/null 2>&1; then
        # Use wget if curl is not available
        wget -q --spider "$JUICE_SHOP_URL" > /dev/null 2>&1
    else
        # Fallback to nc (netcat) for basic connectivity
        nc -z localhost 3000 > /dev/null 2>&1
    fi
}

# Check if Docker container is running
echo "🔍 Checking Docker container status..."
if docker compose ps | grep -q "juice-shop-app.*running"; then
    echo "✅ Container is running"
else
    echo "❌ Container is not running"
    echo "💡 Start with: ./start.sh"
    exit 1
fi

echo ""
echo "🌐 Checking web service availability..."

# Wait for service to be available
while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo "⏳ Attempt $ATTEMPT/$MAX_ATTEMPTS..."
    
    if check_service; then
        echo "✅ Juice Shop is healthy and accessible!"
        echo ""
        echo "🌐 Application URL: $JUICE_SHOP_URL"
        echo "📊 Score Board: $JUICE_SHOP_URL/#/score-board"
        echo "⚙️  Administration: $JUICE_SHOP_URL/#/administration"
        echo ""
        echo "🎉 Ready for testing!"
        exit 0
    fi
    
    if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
        echo "❌ Health check failed after $MAX_ATTEMPTS attempts"
        echo ""
        echo "🔍 Troubleshooting steps:"
        echo "1. Check container logs: docker compose logs"
        echo "2. Verify port 3000 is not in use: lsof -i :3000"
        echo "3. Restart the application: ./stop.sh && ./start.sh"
        exit 1
    fi
    
    sleep 2
    ((ATTEMPT++))
done
