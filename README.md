
# RedHat Lab for RH124 running on VirtualBox

### Requirement

+  VirtualBox
+  Vagrant

### Usage

```
vagrant up

vagrant down

vagrant destroy -f
```

### vagrant --version

> Vagrant 2.2.9

### vboxmanage --version

> 6.1.12r139181

### topology

```
172.25.250.254    bastion        bastion.lab.example.com
172.25.250.9      workstation	   workstation.lab.example.com
172.25.250.10     servera        servera.lab.example.com
172.25.250.11     serverb        serverb.lab.example.com
```

### plugins
to install the vagran plugin run the following command:

```
vagrant plugin install vagrant-hostmanager
```

### default credentials

```
user: root
pass: toor
```