#!/bin/bash

# This script does the AMI harening tasks by executing bash commands
# We can't directly copy the conf files to "root" owned directories via packer file provisioned
# So we put the files in /tmp and move them by executing this shell script

cp /tmp/files/cis-modprobe.conf /etc/modprobe.d
cp /tmp/files/cis-sysctl.conf /etc/sysctl.d
cp /tmp/files/sshd_config /etc/ssh
cp /tmp/files/ssh_banner /etc/ssh
cp /tmp/files/00-motd-warning /etc/update-motd.d

chmod 755 /etc/update-motd.d/00-motd-warning

find /var/log -type f -exec chmod g-wx,o-rwx {} +

rm -rf /tmp/files
