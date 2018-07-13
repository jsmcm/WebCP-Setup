#!/bin/bash

apt-get install clamav-daemon -y

mkdir /var/log/clamav
chown clamav.clamav /var/log/clamav

usermod -a -G Debian-exim clamav
adduser clamav Debian-exim


cd /etc/clamav
cat /etc/clamav/clamd.conf | sed "s/AllowSupplementaryGroups false/AllowSupplementaryGroups true/g" > /etc/clamav/temp.clamd.conf
cat /etc/clamav/temp.clamd.conf | sed "s/#AllowSupplementaryGroups/AllowSupplementaryGroups/g" > /etc/clamav/clamd.conf

rm -fr /etc/clamav/temp.clamd.conf

