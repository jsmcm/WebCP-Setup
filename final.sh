#!/bin/bash

rm /tmp/webcp_username

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

mkdir /tmp/php
chmod 777 /tmp/php

rm -fr /tmp/email.webcp

/usr/webcp/update/update.sh

echo "y" | ufw enable
