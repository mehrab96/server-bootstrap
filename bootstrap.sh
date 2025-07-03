cat > bootstrap.sh << 'EOF'
#!/usr/bin/env bash
set -e

echo "🔧 Updating packages and installing Git..."
apt-get update
apt-get install -y git curl ca-certificates apt-transport-https software-properties-common

echo "🐳 Installing Docker..."
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "📦 Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="1.29.2"
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "✅ Prerequisites installed successfully."
EOF
