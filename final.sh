#!/bin/bash

echo "* * * * * /usr/webcp/director.sh > /dev/null 2>&1" | crontab

cd /var/www/html/webcp
composer install

mkdir /var/www/html/webcp/nm
touch /var/www/html/webcp/nm/letsencrypt.install
