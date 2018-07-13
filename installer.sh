#!/bin/bash

apt-get install wget -y

wget http://api.webcp.pw/downloads/2.0.0/1-init.sh
chmod 755 /tmp/1-init.sh
/tmp/1-init.sh
rm -fr /tmp/1-init.sh

wget http://api.webcp.pw/downloads/2.0.0/2-nginx.sh
chmod 755 /tmp/2-nginx.sh
/tmp/2-nginx.sh
rm -fr /tmp/2-nginx.sh

wget http://api.webcp.pw/downloads/2.0.0/3-php.sh
chmod 755 /tmp/3-php.sh
/tmp/3-php.sh
rm -fr /tmp/3-php.sh
