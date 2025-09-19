#!/bin/sh
set -e

# Function to get system architecture
get_architecture() {
    local arch="$(uname -m)"
    case "$arch" in
        x86_64|amd64) echo "amd64" ;;
        aarch64|arm64) echo "arm64" ;;
        armv7l) echo "arm" ;;
        *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
    esac
}

# Install SOPS (Mozilla's secrets manager)
SOPS_VERSION="3.9.0"
ARCH=$(get_architecture)

echo "Installing SOPS v${SOPS_VERSION} for ${ARCH}..."

# Download and install SOPS binary
curl -fsSL -o /usr/local/bin/sops "https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.${ARCH}"
chmod +x /usr/local/bin/sops

# Verify installation
echo "SOPS installation complete:"
sops --version
