#!/bin/bash

# OWASP Juice Shop - Setup Verification Script
# This script checks if all prerequisites are met

echo "🔧 OWASP Juice Shop Setup Check"
echo "================================"

# Check if Docker is installed
if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker is installed: $(docker --version)"
else
    echo "❌ Docker is not installed"
    echo "💡 Install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is available
if docker compose version >/dev/null 2>&1; then
    echo "✅ Docker Compose is available: $(docker compose version)"
elif command -v docker-compose >/dev/null 2>&1; then
    echo "✅ Docker Compose is available: $(docker-compose --version)"
    echo "⚠️  Note: Using legacy docker-compose command"
else
    echo "❌ Docker Compose is not available"
    echo "💡 Install Docker Compose or update Docker to a newer version"
    exit 1
fi

# Check if Docker daemon is running
if docker info >/dev/null 2>&1; then
    echo "✅ Docker daemon is running"
else
    echo "❌ Docker daemon is not running"
    echo "💡 Start Docker Desktop or Docker daemon"
    exit 1
fi

# Check if port 3000 is available
if lsof -i :3000 >/dev/null 2>&1; then
    echo "⚠️  Port 3000 is currently in use"
    echo "🔍 Process using port 3000:"
    lsof -i :3000
    echo "💡 Stop the process or modify docker-compose.yml to use a different port"
else
    echo "✅ Port 3000 is available"
fi

# Check if all required files exist
echo ""
echo "📁 Checking project files..."
files=("docker-compose.yml" "README.md" "start.sh" "stop.sh" "reset.sh" "health-check.sh")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
    fi
done

echo ""
echo "🎉 Setup check complete!"
echo "💡 Run ./start.sh to launch Juice Shop"
