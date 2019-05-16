#!/bin/bash

echo "* * * * * /usr/webcp/director.sh > /dev/null 2>&1" | crontab

if [ ! -d "/var/log/webcp" ]
then
	mkdir /var/log/webcp
	chown www-data.www-data /var/log/webcp
fi

cd /var/www/html/webcp
composer install

mkdir /var/www/html/webcp/nm
chown www-data.www-data /var/www/html/webcp -R
touch /var/www/html/webcp/nm/letsencrypt.install

echo "y" | ufw enable
