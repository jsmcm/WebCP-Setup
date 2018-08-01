#!/bin/bash

mkdir -p /usr/webcp
cd /usr/webcp

##wget http://api.webcp.pw/downloads/2.0.0/scripts.zip
##unzip scripts.zip

git clone http://api.webcp.pw/downloads/2.0.0/git/scripts.git ./
chmod 755 /usr/webcp -R

##rm -fr /usr/webcp/scripts.zip



