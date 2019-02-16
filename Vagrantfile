# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    $num_nodes = 2
    (1..$num_nodes).each do |i|
        config.vm.define "spark-node#{i}" do |node|
            node.vm.box = "qzchenwl/centos"
            node.vm.synced_folder ".", "/vagrant", type: "virtualbox"
            node.vm.hostname = "spark-node#{i}"
            ip = "10.0.1.#{i+100}"
            node.vm.network "private_network", ip: ip
            node.vm.provider "virtualbox" do |vb|
                vb.memory = "8192"
                vb.cpus = 2
                vb.name = "spark-node#{i}"
            end

            node.vm.provision "file", source: "keys/id_rsa", destination: "$HOME/.ssh/id_rsa"
            node.vm.provision "file", source: "keys/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"
            node.vm.provision "shell", privileged: false, inline: <<-SCRIPT
                cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
            SCRIPT

            node.vm.provision "shell", path: "scripts/bootstrap.sh"
            if i == 1
                puts "spark-node#{i} is master"
                node.vm.provision "shell", path: "scripts/init-master.sh"
            else
                puts "spark-node#{i} is worker"
                #node.vm.provision "shell", path: "scripts/init-worker.sh", privileged: false
            end
        end
    end
end
