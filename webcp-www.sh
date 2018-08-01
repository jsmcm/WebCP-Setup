#!/bin/bash

mkdir -p /var/www/html/webcp
cd /var/www/html/webcp
git clone http://api.webcp.pw/downloads/2.0.0/git/webcp.git ./
chown www-data.www-data /var/www/html/webcp -R


cd /var/www/html/
wget http://api.webcp.pw/downloads/2.0.0/editor.zip
unzip editor.zip
chown www-data.www-data /var/www/html/editor -R

rm -fr /var/www/html/editor.zip

cd /etc/skel
wget http://api.webcp.pw/downloads/2.0.0/skel.zip
unzip skel.zip
rm -fr /etc/skel/skel.zip
ln -s /var/www/html/editor .editor


chown www-data.www-data /var/www/html/ -R
