# création utilisateur github runner
sudo useradd github-runner --shell /bin/bash
sudo mkdir /home/github-runner
cd /home/github-runner/
sudo chown github-runner ../github-runner
loginctl enable-linger github-runner
sudo su github-runner
sudo -i -u github-runner
export XDG_RUNTIME_DIR=/run/user/$UID 

# Docker installation
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF

curl https://get.docker.com/ | bash
dockerd-rootless-setuptool.sh install

# Gestion des permissions
sudo groupadd docker
sudo usermod -aG docker github-runner
exit
sudo su github-runner

# Download github-runner
mkdir actions-runner && cd actions-runner # Download the latest runner package
curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz # Extract the installer
tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz

# Configure
cd actions-runner/
./config.sh --url https://github.com/stractus/hello-github-actions --token AAFPWAJXNUGUJK7RMKLTPTTAYNXPY

# Run
./run.sh