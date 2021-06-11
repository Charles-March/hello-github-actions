#!/bin/sh

# Docker installation
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF

curl https://get.docker.com/ | bash
dockerd-rootless-setuptool.sh install

# Download github-runner
mkdir actions-runner && cd actions-runner # Download the latest runner package
curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz # Extract the installer
tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz

# Configure
cd actions-runner/
./config.sh --url https://github.com/stractus/hello-github-actions --token ${token}

# Run
./run.sh