#!/bin/bash

##################
#
# SSHD
#
##################

cd /etc/ssh/
cp sshd_config bck.sshd_config

UserName=`cat /tmp/webcp_username`
UserName="$(echo -e "${UserName}" | tr -d '[:space:]')"

echo "Port 7533" > /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
echo "UsePAM yes" >> /etc/ssh/sshd_config
echo "X11Forwarding yes" >> /etc/ssh/sshd_config
echo "PrintMotd no" >> /etc/ssh/sshd_config
echo "AcceptEnv LANG LC_*" >> /etc/ssh/sshd_config
echo "Subsystem sftp  /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "Match User root" >> /etc/ssh/sshd_config
echo " ChrootDirectory none" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "Match User $UserName" >> /etc/ssh/sshd_config
echo " ChrootDirectory none" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "Match User *" >> /etc/ssh/sshd_config
echo " ChrootDirectory %h" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config



