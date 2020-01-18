# Vagrant Kubernetes Environment
This projects sets up a distributed Kubernetes environment based on VMs.

You need to have Vagrant installed on your system. 

## Instructions

* `vagrant up` - Create and bring up the VMs
* `vagrant halt` - Bring down all VMs
* `vagrant destroy` - Bring down and delete all VMs
* `vagrant status` - Check status of the VMs
* `vagrant ssh [node]` - Connect to node via SSH

For a complete list of commands see the [Vagrant-CLI](https://www.vagrantup.com/docs/cli/)

Check if cluster is up an running by executing:

1. `vagrant ssh kmaster` - connect to Kubernetes master node
2. `kubectl cluster-info` - retrieve Kubernetes cluster info

You should see:

```bash
Kubernetes master is running at https://172.42.42.100:6443
KubeDNS is running at https://172.42.42.100:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

3. `kubectl get nodes` - list all nodes in the Kubernetes cluster

```bash
NAME         STATUS   ROLES    AGE   VERSION
kubemaster   Ready    master   18m   v1.17.1
kubi1        Ready    <none>   16m   v1.17.1
kubi2        Ready    <none>   14m   v1.17.1
kubi3        Ready    <none>   12m   v1.17.1
```