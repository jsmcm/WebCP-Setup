#!/bin/bash

echo "/home/*/nginx-*.log {" > /etc/logrotate.d/nginx
echo "" >> /etc/logrotate.d/nginx
echo "	daily" >> /etc/logrotate.d/nginx
echo "	rotate 4" >> /etc/logrotate.d/nginx
echo " 	size 32M" >> /etc/logrotate.d/nginx
echo "	compress" >> /etc/logrotate.d/nginx
echo "" >> /etc/logrotate.d/nginx
echo "	delaycompress" >> /etc/logrotate.d/nginx
echo "" >> /etc/logrotate.d/nginx
echo "	postrotate" >> /etc/logrotate.d/nginx
echo "		[ ! -f /var/run/nginx.pid ] || kill -USR1 `cat /var/run/nginx.pid`" >> /etc/logrotate.d/nginx
echo "	endscript" >> /etc/logrotate.d/nginx
echo "" >> /etc/logrotate.d/nginx
echo "}" >> /etc/logrotate.d/nginx


echo "/home/*/phperrors.log {" > /etc/logrotate.d/phperrors
echo "	rotate 12" >> /etc/logrotate.d/phperrors
echo "	daily" >> /etc/logrotate.d/phperrors
echo "	size 32M" >> /etc/logrotate.d/phperrors
echo "	missingok" >> /etc/logrotate.d/phperrors
echo "	notifempty" >> /etc/logrotate.d/phperrors
echo "	compress" >> /etc/logrotate.d/phperrors
echo "	delaycompress" >> /etc/logrotate.d/phperrors
echo "	postrotate" >> /etc/logrotate.d/phperrors
echo "		/usr/lib/php/php7.2-fpm-reopenlogs" >> /etc/logrotate.d/phperrors
echo "		/usr/lib/php/php5.6-fpm-reopenlogs" >> /etc/logrotate.d/phperrors
echo "	endscript" >> /etc/logrotate.d/phperrors
echo "}" >> /etc/logrotate.d/phperrors

