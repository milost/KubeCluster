#!/bin/sh

echo "### boostrap master ###"
echo "Running as: $(whoami)"

echo "[TASK 1] Initialize Kubernetes Cluster (172.42.42.100)"
kubeadm init \
    --apiserver-advertise-address=172.42.42.100 \
    --pod-network-cidr=192.168.0.0/16 \
    >> /root/kubeinit.log 2>/dev/null

echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# Deploy Calico network
# echo "[TASK 3] Deploy Calico network"
# su - vagrant -c "kubectl create -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml"

echo "[TASK 3] Deploy Flannel Network"
su - vagrant -c "kubectl create -f /vagrant/kube-flannel.yml"

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > joincluster.sh
chown vagrant:vagrant joincluster.sh
