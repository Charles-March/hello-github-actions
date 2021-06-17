#!/bin/sh
# $1 for url
# $2 for token

export RUNNER_ALLOW_RUNASROOT="1"

# Docker installation
sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF

curl https://get.docker.com/ | bash

# Download github-runner
mkdir /action-runner
cd /action-runner

curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz # Extract the installer
tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz
ls

# Configure
./config.sh --url $1 --token $2

# Run
./run.sh