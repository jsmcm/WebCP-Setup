#!/bin/bash

##################
#
# MySQL
#
##################

PASSWORD=$1

if [ "$PASSWORD" == "" ]
then
	echo "ERROR: Please supply the MySQL password!!!"
	exit
fi

gpg --keyserver hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
gpg -a --export CD2EFD2A | sudo apt-key add -


echo "deb http://repo.percona.com/apt precise main" > /etc/apt/sources.list.d/percona.repo.list
echo "deb-src http://repo.percona.com/apt precise main" >> /etc/apt/sources.list.d/percona.repo.list

apt-get update -y

One="percona-server-server-5.5 percona-server-server/root_password password $PASSWORD"
Two="percona-server-server-5.5 percona-server-server/root_password_again password $PASSWORD"

debconf-set-selections <<< $One
debconf-set-selections <<< $Two

apt-get install percona-server-server-5.5 -y --allow-unauthenticated
apt-get install percona-server-client-5.5 -y --allow-unauthenticated



echo "[mysqld]" > /etc/mysql/conf.d/mysqld.cnf
echo "" >> /etc/mysql/conf.d/mysqld.cnf
echo "skip_name_resolve" >> /etc/mysql/conf.d/mysqld.cnf
echo "max_allowed_packet=10M" >> /etc/mysql/conf.d/mysqld.cnf
echo "log-warnings = 2" >> /etc/mysql/conf.d/mysqld.cnf
echo "log-error=/var/log/mysqld.log" >> /etc/mysql/conf.d/mysqld.cnf
echo "" >> /etc/mysql/conf.d/mysqld.cnf

service mysql stop
service mysql start
service mysql restart

$(mysql -u root -p$PASSWORD -se "DROP DATABASE test;")
$(mysql -u root -p$PASSWORD -se "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');")
$(mysql -u root -p$PASSWORD -se "DELETE FROM mysql.user WHERE User='';")

cd /tmp
/usr/bin/wget https://api.webcp.io/downloads/3.0.0/cpadmin.sql


mysql -u root -p$PASSWORD < cpadmin.sql
rm -fr cpadmin.sql


