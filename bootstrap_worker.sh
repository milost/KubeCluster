#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Join node to Kubernetes Cluster"
echo "Running as: $(whoami)"
apt-get install -y sshpass >/dev/null 2>&1
sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@kubemaster.synapps.com:joincluster.sh joincluster.sh 2>/dev/null
bash /home/vagrant/joincluster.sh >/dev/null 2>&1