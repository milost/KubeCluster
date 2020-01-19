# -*- mode: ruby -*-
# vi: set ft=ruby :

# If this is set, Vagrant will not perform any parallel operations
# (such as parallel box provisioning). All operations will be 
# performed in serial.
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

NodeCount = 3
MasterMemory = 4096
MasterCpus = 2
WorkerMemory = 2048
WorkerCpus = 1

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox"

  # Basic box provisioning
  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.box = "ubuntu/xenial64"
    kmaster.vm.hostname = "kubemaster.synapps.com"
    kmaster.vm.network "private_network", ip: "172.42.42.100"
    kmaster.vm.provider "virtualbox" do |v|
      v.name = "kmaster"
      v.memory = MasterMemory
      v.cpus = MasterCpus
    end
    kmaster.vm.provision "shell", path: "bootstrap_master.sh"
  end

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "kubi#{i}" do |workernode|
      workernode.vm.box = "ubuntu/xenial64"
      workernode.vm.hostname = "kubi#{i}.synapps.com"
      workernode.vm.network "private_network", ip: "172.42.42.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "kubi#{i}"
        v.memory = WorkerMemory
        v.cpus = WorkerCpus
      end
      workernode.vm.provision "shell", path: "bootstrap_worker.sh"
    end
  end

end
