#!/bin/bash

# === Configuration ===
BACKEND_NAME="illuminant-backend"
BACKEND_DIR="/var/www/Illuminant/Backend"
FRONTEND_DIR="/var/www/Illuminant/docs"    # Already pure HTML/CSS/JS
DEPLOY_DIR="/var/www/Illuminant/docs"      # NGINX root (same as frontend)
NODE_ENV="production"

echo "===================="
echo "🚀 Starting Deployment"
echo "===================="

# === 1. Pull latest backend changes ===
echo "📥 Pulling latest code..."
cd "$BACKEND_DIR" && git pull origin main

# === 2. Install backend dependencies ===
echo "📦 Installing backend dependencies..."
cd "$BACKEND_DIR"
npm install

# === 3. (Optional) Pull latest frontend files ===
echo "📥 Updating frontend (static HTML/CSS/JS)..."
cd "$FRONTEND_DIR" && git pull origin main

# === 4. Restart backend with PM2 ===
echo "🔁 Restarting backend with PM2..."
cd "$BACKEND_DIR"
pm2 restart "$BACKEND_NAME" || pm2 start src/index.js --name "$BACKEND_NAME"

# === 5. Reload NGINX ===
echo "🌐 Reloading NGINX..."
sudo nginx -t && sudo systemctl reload nginx

echo "✅ Deployment complete!"
