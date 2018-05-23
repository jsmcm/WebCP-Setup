#!/bin/bash

apt-get install clamav-daemon

mkdir /var/log/clamav
chown clamav.clamav /var/log/clamav

usermod -a -G Debian-exim clamav

