#!/bin/bash

##################
#
# MySQL
#
##################


echo "[mysqld_safe]" > /etc/mysql/mysql.conf.d/mysqld.cnf
echo "socket          = /var/run/mysqld/mysqld.sock" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "nice            = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "[mysqld]" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_connections = 1000" >> /etc/mysql/mysql.conf.d/mysqld.cnf
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
echo "#query_cache_limit       = 1M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "#query_cache_size        = 16M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "expire_logs_days        = 10" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_binlog_size   = 100M" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "skip_name_resolve" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "max_allowed_packet=10M" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "#log_warnings = 2" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "log_error=/var/log/mysql/mysqld.log" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "character-set-server = utf8mb4" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "collation-server = utf8mb4_unicode_ci" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "#init_connect='SET collation_connection = utf8mb4_unicode_ci'" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "#init_connect='SET NAMES utf8mb4'" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "# If you have trouble with 'ERROR 1071 (42000): Specified key was too long; max key length is ____ bytes'" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "#innodb-large-prefix=true" >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo "#skip-character-set-client-handshake" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "character-set-client-handshake = FALSE" >> /etc/mysql/mysql.conf.d/mysqld.cnf


echo "[client]" > /etc/mysql/conf.d/mysql.cnf
echo "default-character-set = utf8mb4" >> /etc/mysql/conf.d/mysql.cnf

echo "[mysql]" >> /etc/mysql/conf.d/mysql.cnf
echo "default-character-set = utf8mb4" >> /etc/mysql/conf.d/mysql.cnf

mkdir -p /etc/systemd/system/mysql.service.d
echo "[Service]" > /etc/systemd/system/mysql.service.d/override.conf 
echo "LimitNOFILE=4096" >> /etc/systemd/system/mysql.service.d/override.conf 


systemctl daemon-reload



