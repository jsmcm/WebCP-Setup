#!/bin/bash

mkdir -p /var/www/html/webcp
cd /var/www/html/webcp
git clone https://github.com/jsmcm/WebCP.git ./
chown www-data.www-data /var/www/html/webcp -R


mkdir -p /var/www/html/editor
cd /var/www/html/editor
git clone https://bitbucket.org/webcp/editor.git ./
chown www-data.www-data /var/www/html/editor -R

rm -fr /var/www/html/editor.zip

cd /etc/skel
wget https://api.webcp.io/downloads/3.0.0/skel.zip
unzip skel.zip
rm -fr /etc/skel/skel.zip
ln -s /var/www/html/editor .editor


chown www-data.www-data /var/www/html/ -R
