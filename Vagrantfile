VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
machines = YAML.load_file('./extras/machines.yaml')

# Deatils of vagrant file
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false

  config.vm.define machines["bastion_vmname"] do |bastion|
      bastion.vm.box = "centos/8"
      bastion.vm.hostname = machines["bastion_hostname"]
      bastion.vm.network "private_network", ip: machines["bastion_ip"]
      bastion.vm.provision "shell", path: "./extras/initial-setup.sh"
      bastion.vm.provider "virtualbox" do |v|
        v.customize [
          'modifyvm', :id,
          '--groups', '/RH124'
        ]
        v.name = machines["bastion_vmname"]
        v.memory = 2048
        v.cpus = 2
      end
  end

  config.vm.define machines["servera_vmname"] do |servera|
      servera.vm.box = "centos/8"
      servera.vm.hostname = machines["servera_hostname"]
      servera.vm.network "private_network", ip: machines["servera_ip"]
      servera.vm.provision "shell", path: "./extras/initial-setup.sh"
      servera.vm.provider "virtualbox" do |v|
        v.customize [
          'modifyvm', :id,
          '--groups', '/RH124'
        ]
        v.name = machines["servera_vmname"]
        v.memory = 1024
        v.cpus = 2
      end
  end

  config.vm.define machines["serverb_vmname"] do |serverb|
      serverb.vm.box = "centos/8"
      serverb.vm.hostname = machines["serverb_hostname"]
      serverb.vm.network "private_network", ip: machines["serverb_ip"]
      serverb.vm.provision "shell", path: "./extras/initial-setup.sh"
      serverb.vm.provider "virtualbox" do |v|
        v.customize [
          'modifyvm', :id,
          '--groups', '/RH124'
        ]
        v.name = machines["serverb_vmname"]
        v.memory = 1024
        v.cpus = 2
      end
  end

end
