#!/bin/bash

echo "* * * * * /usr/webcp/director.sh > /dev/null 2>&1" | crontab

cd /var/www/html/webcp
composer install
