#!/bin/bash


##################
#
# PHP
#
##################

apt install software-properties-common
add-apt-repository ppa:ondrej/php
apt update

apt-get install php5.6-fpm php5.6-mysql php5.6-xml php5.6-gd php5.6-zip php5.6-curl php5.6-mbstring  php5.6-xml php5.6-soap php5.6-imap php5.6-opcache -y
apt-get install php5.6-pear -y

apt-get install php5.6-intl php5.6-mail-mime php5.6-mail-mimedecode php5.6-net-smtp php5.6-net-socket php5.6-cli php5.6-common php5.6-curl php5.6-fpm php5.6-gd php5.6-imap php5.6-intl php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-opcache php5.6-readline php5.6-soap php5.6-xml php5.6-zip -y

apt-get install php5.6-mcrypt php5.6-opcache php5.6-auth



cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip --no-check-certificate
unzip ioncube_loaders_lin_x86-64.zip
cp /tmp/ioncube/ioncube_loader_lin_5.6.so /etc/php/5.6

service php5.6-fpm restart




