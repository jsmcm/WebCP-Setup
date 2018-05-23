#!/bin/bash


yum install iptables iptables-ipv6 -y

cd /tmp
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh
cd /tmp
rm -fr csf*

cd /etc/csf
rm -fr csf.conf
wget http://webcp.pw/api/downloads/2.0.0/csf.conf

cd /usr/local/csf/bin
rm -fr regex.custom.pm
wget http://webcp.pw/api/downloads/2.0.0/regex.custom.pm

service lfd restart
csf -r

cd /tmp
wget https://solidshellsecurity.com/_public/scripts/rkhunter_install.sh -v && chmod u+x rkhunter_install.sh && ./rkhunter_install.sh --time d
rm -fr /tmp/rkhunter_install.sh

