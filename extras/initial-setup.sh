#!/bin/bash

#-- allow root and password auth
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

useradd student -G wheel

echo "redhat" | passwd --stdin root
echo "student" | passwd --stdin student

dnf install vim -y
