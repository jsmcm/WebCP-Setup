#!/bin/bash

cd /var/www/html/
wget http://api.webcp.pw/downloads/2.0.0/webcp.zip
unzip webcp.zip
chown www-data.www-data /var/www/html/webcp -R


wget http://api.webcp.pw/downloads/2.0.0/editor.zip
unzip editor.zip
chown www-data.www-data /var/www/html/editor -R

rm -fr /var/www/html/webcp.zip
rm -fr /var/www/html/editor.zip

cd /etc/skel
wget http://api.webcp.pw/downloads/2.0.0/skel.zip
unzip skel.zip
rm -fr /etc/skel/skel.zip
ln -s /var/www/html/editor .editor


chown www-data.www-data /var/www/html/ -R
