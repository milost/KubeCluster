# Vagrant Kubernetes Environment
This projects sets up a Kubernetes environment based on VirtualMachines (VMs).
The network will contain one Kubernetes Master VM and 3 Worker VMs.

[Requirements](#requirements) are described below.

## Instructions
1. `vagrant up` - Create and bring up the cluster
2. `vagrant ssh kmaster` - connect to Kubernetes master node
3. `kubectl cluster-info` - retrieve Kubernetes cluster info

You should see:

```bash
Kubernetes master is running at https://172.42.42.100:6443
KubeDNS is running at https://172.42.42.100:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

4. `kubectl get nodes` - list all nodes in the Kubernetes cluster

```bash
NAME         STATUS   ROLES    AGE   VERSION
kubemaster   Ready    master   18m   v1.17.1
kubi1        Ready    <none>   16m   v1.17.1
kubi2        Ready    <none>   14m   v1.17.1
kubi3        Ready    <none>   12m   v1.17.1
```

### List of vagrant commands
* `vagrant up` - Create and bring up the VMs
* `vagrant halt` - Bring down all VMs
* `vagrant destroy` - Bring down and delete all VMs
* `vagrant status` - Check status of the VMs
* `vagrant ssh [node]` - Connect to node via SSH

For a complete list of commands see the [Vagrant-CLI](https://www.vagrantup.com/docs/cli/)

## Requirements

### Key Component
In order of layers deployed.

1. [VirtualBox - hypervisor](https://github.com/mirror/vbox)
2. [Vagrant - deployment manager](https://github.com/hashicorp/vagrant)
3. [Kubernetes - containerized applications manager](https://github.com/kubernetes/kubernetes)
4. [flannel - overlay network for Kubernetes](https://github.com/coreos/flannel)

### Installation

#### debian/sid
Install dependencies with: `apt-get install vagrant virtualbox` (Jan 2020)

Note: `libvirt` which is debian's default provisioner. Is not required for this setup.
