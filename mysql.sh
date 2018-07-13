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

ufw allow 3306/tcp


apt-get update -y


One="mysql-server mysql-server/root_password password $PASSWORD"
Two="mysql-server mysql-server/root_password_again password $PASSWORD"

debconf-set-selections <<< $One
debconf-set-selections <<< $Two


sudo apt-get -y install mysql-server



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
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/cpadmin.sql


mysql -u root -p$PASSWORD < cpadmin.sql
rm -fr cpadmin.sql

