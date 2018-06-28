# -*- mode: ruby -*-
# vi: set ft=ruby :

NODE_IP = "172.30.0.9"
NODE_VCPUS = 2
NODE_MEMORY_SIZE = 4096


Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provider :virtualbox do |v|
    v.cpus = NODE_VCPUS
    v.gui = false
    v.memory = NODE_MEMORY_SIZE
  end

  config.vm.network :private_network, ip: NODE_IP
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 8443, host: 8443

  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    yum check-update
    yum -y install nano git docker wget
    groupadd docker
    usermod -aG docker vagrant
    echo '{ "insecure-registries" : ["172.30.0.0/16"] }' > /etc/docker/daemon.json
    systemctl enable docker
    systemctl start docker
    wget https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz
    tar -xf openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz
    cd openshift-origin-client-tools-v3.9.0-191fece-linux-64bit
    cp oc /usr/bin
    rm -rf ~/openshift-origin-client-tools*
  SHELL
end
