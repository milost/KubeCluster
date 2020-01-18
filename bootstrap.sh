echo "Running as: $(whoami)"
# Update packages
apt-get update >/dev/null 2>&1
# Upgrade packages
apt-get upgrade >/dev/null 2>&1

# Install additional packages
apt-get install -y git htop 

# Update hosts file
echo "[TASK 1] Updating /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 kubemaster.synapps.com kubemaster
172.42.42.101 kubi1.synapps.com kubi1
172.42.42.102 kubi2.synapps.com kubi2
172.42.42.103 kubi3.synapps.com kubi3
EOF

# Install Docker
echo "[TASK 2] Installing Docker"
apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common
# ethtool \
# ebtables \

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add stable repository
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

# Update apt package index
apt-get update >/dev/null 2>&1

# Install Docker via apt
apt-get install -y docker-ce docker-ce-cli containerd.io >/dev/null 2>&1
# Add user to docker group
usermod -aG docker vagrant


# Enable docker service ... just to be sure
echo "[TASK 3] Enable and start docker service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

# Add sysctl settings
echo "[TASK 4] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "[TASK 5] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Install Kubernetes
echo "[TASK 6] Installing Kubernetes (kubeadm, kubelet and kubectl)"
# Add Kubernetes's official GPG key
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# Add stable repository
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
# Update apt package index
apt-get update >/dev/null 2>&1
# Install
sudo apt-get install -y kubelet kubeadm kubectl >/dev/null 2>&1
# Hold fix the version
sudo apt-mark hold kubelet kubeadm kubectl >/dev/null 2>&1

# Start and Enable kubelet service
echo "[TASK 7] Enable and start kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

# Enable ssh password authentication
echo "[TASK 8] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 9] Set root password"
echo "root:kubeadmin" | sudo chpasswd >/dev/null 2>&1
echo "vagrant:kubeadmin" | sudo chpasswd >/dev/null 2>&1
