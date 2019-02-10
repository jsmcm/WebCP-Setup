#!/bin/bash

##################
#
# SSHD
#
##################

cd /etc/ssh/
cp sshd_config bck.sshd_config

cat bck.sshd_config | sed "s/Port 22/Port 7533/g" > 1.sshd_config
cat 1.sshd_config | sed "s/#Port/Port/g" > 2.sshd_config

cat 2.sshd_config | sed "s/PermitRootLogin yes/PermitRootLogin no/g" > 1.sshd_config
cat 1.sshd_config | sed "s/#PermitRootLogin/PermitRootLogin/g" > sshd_config

rm -fr 1.sshd_config
rm -fr 2.sshd_config

