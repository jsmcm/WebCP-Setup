#!/bin/bash

mkdir -p /usr/webcp
cd /usr/webcp

git clone https://github.com/jsmcm/WebCP-Scripts.git ./
git checkout master
chmod 755 /usr/webcp -R



