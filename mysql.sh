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


echo "[mysqld_safe]" > /etc/mysql/mysql.conf.d/mysqld.cnf
echo "socket          = /var/run/mysqld/mysqld.sock" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "nice            = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "[mysqld]" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "user            = mysql" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "pid-file        = /var/run/mysqld/mysqld.pid" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "socket          = /var/run/mysqld/mysqld.sock" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "port            = 3306" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "basedir         = /usr" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "datadir         = /var/lib/mysql" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "tmpdir          = /tmp" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "lc-messages-dir = /usr/share/mysql" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "skip-external-locking" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "bind-address            = 0.0.0.0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "key_buffer_size         = 16M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_allowed_packet      = 16M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "thread_stack            = 192K" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "thread_cache_size       = 8" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "myisam-recover-options  = BACKUP" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "query_cache_limit       = 1M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "query_cache_size        = 16M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "expire_logs_days        = 10" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_binlog_size   = 100M" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "skip_name_resolve" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_allowed_packet=10M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "log_warnings = 2" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "log_error=/var/log/mysql/mysqld.log" >> /etc/mysql/mysql.conf.d/mysqld.cnf

service mysql stop
service mysql start
service mysql restart

$(mysql -u root -p$PASSWORD -se "DROP DATABASE test;")
$(mysql -u root -p$PASSWORD -se "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');")
$(mysql -u root -p$PASSWORD -se "DELETE FROM mysql.user WHERE User='';")

cd /tmp
/usr/bin/wget https://api/webcp.io/downloads/2.0.0/cpadmin.sql


mysql -u root -p$PASSWORD < cpadmin.sql
rm -fr cpadmin.sql


