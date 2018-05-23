#!/bin/bash

yum install pure-ftpd -y

service pure-ftpd start

cd /etc/pure-ftpd
rm -fr *

wget http://webcp.pw/api/downloads/2.0.0/pureftpd.zip

unzip pureftpd.zip
rm -fr pureftpd.zip

cat pureftpd-mysql.tmp | sed "s/WEBCP_PASSWORD/eEF43%^fHT/g" > pureftpd-mysql.conf
rm -fr pureftpd-mysql.tmp


