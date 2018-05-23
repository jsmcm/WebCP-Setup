#!/bin/bash

##################
#
# MySQL
#
##################


gpg --keyserver hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
gpg -a --export CD2EFD2A | sudo apt-key add -


echo "deb http://repo.percona.com/apt precise main" > /etc/apt/sources.list.d/percona.repo.list
echo "deb-src http://repo.percona.com/apt precise main" >> /etc/apt/sources.list.d/percona.repo.list


apt-get update -y

debconf-set-selections <<< 'percona-server-server-5.5 percona-server-server/root_password password eEF43%^fHT'
debconf-set-selections <<< 'percona-server-server-5.5 percona-server-server/root_password_again password eEF43%^fHT'
apt-get install percona-server-server-5.5 -y --allow-unauthenticated

apt-get install percona-server-client-5.5 -y --allow-unauthenticated

apt-get install dovecot-mysql -y

service mysql restart

$(mysql -u root -peEF43%^fHT -se "DROP DATABASE test;")
$(mysql -u root -peEF43%^fHT -se "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');")
$(mysql -u root -peEF43%^fHT -se "DELETE FROM mysql.user WHERE User='';")

cd /tmp
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/cpadmin.sql


mysql -u root -peEF43%^fHT < cpadmin.sql
rm -fr cpadmin.sql


