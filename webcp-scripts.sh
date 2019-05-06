#!/bin/bash

mkdir -p /usr/webcp
cd /usr/webcp

git clone https://bitbucket.org/webcp/scripts.git ./
git checkout master
chmod 755 /usr/webcp -R



