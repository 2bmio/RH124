VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
machines = YAML.load_file('./extras/machines.yaml')

# Magic ↓ ~~ ↓
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false

  config.vm.define machines["bastion_vmname"] do |bastion|
      bastion.vm.box = "centos/8"
      bastion.vm.hostname = machines["bastion_hostname"]
      bastion.vbguest.auto_update = false
      bastion.vm.network "private_network", ip: machines["bastion_ip"]
      bastion.vm.provision "shell", path: "./extras/initial-setup.sh"
      bastion.vm.provider "virtualbox" do |v|
        v.customize [
          'modifyvm', :id,
          '--groups', '/RH124'
        ]
        v.name = machines["bastion_vmname"]
        v.memory = 1024
        v.cpus = 2
      end
  end

  config.vm.define machines["workstation_vmname"] do |workstation|
      workstation.vm.box = "centos/8"
      workstation.vm.hostname = machines["workstation_hostname"]
      workstation.vm.network "private_network", ip: machines["workstation_ip"]
      #────────────────────────────────────────────────────────────#
      # Monkey patch for https://github.com/dotless-de/vagrant-vbguest/issues/367
      class Foo < VagrantVbguest::Installers::CentOS
        def has_rel_repo?
          unless instance_variable_defined?(:@has_rel_repo)
            rel = release_version
            @has_rel_repo = communicate.test("yum repolist")
          end
          @has_rel_repo
        end

        def install_kernel_devel(opts=nil, &block)
          cmd = "yum update kernel -y"
          communicate.sudo(cmd, opts, &block)

          cmd = "yum install -y kernel-devel"
          communicate.sudo(cmd, opts, &block)

          cmd = "shutdown -r now"
          communicate.sudo(cmd, opts, &block)

          begin
            sleep 5
          end until @vm.communicate.ready?
        end
      end
      #────────────────────────────────────────────────────────────#
      workstation.vbguest.installer = Foo
      workstation.vm.provision "shell", path: "./extras/initial-setup.sh"
      workstation.vm.synced_folder '.', '/vagrant', disabled: true
      workstation.vm.synced_folder "./synced", "/synced", type: "virtualbox", owner: "student", group: "student", mount_options: ["uid=1001", "gid=1001"]
      workstation.vm.provision "shell", path: "./extras/workstation-setup.sh"
      workstation.vm.provider "virtualbox" do |v|
        v.customize [
          'modifyvm', :id,
          '--groups', '/RH124'
        ]
        v.name = machines["workstation_vmname"]
        v.memory = 2048
        v.cpus = 2
      end
  end

  config.vm.define machines["servera_vmname"] do |servera|
      servera.vm.box = "centos/8"
      servera.vm.hostname = machines["servera_hostname"]
      servera.vbguest.auto_update = false
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
      serverb.vbguest.auto_update = false
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
