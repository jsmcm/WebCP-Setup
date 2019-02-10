#!/bin/bash

DatabasePassword=$1

if [ "$DatabasePassword" == "" ]
then
	echo "Give password!!!"
	exit
fi


apt-get install pure-ftpd-mysql -y



echo "MYSQLSocket     /var/run/mysqld/mysqld.sock" > /etc/pure-ftpd/db/mysql.conf
echo "MYSQLUser       root" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLPassword   $DatabasePassword" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLDatabase   cpadmin" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLCrypt      md5" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLGetPW      SELECT Password FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess=\"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLGetUID     SELECT Uid FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLGetGID     SELECT Gid FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MYSQLGetDir     SELECT Dir FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MySQLGetQTAFS   SELECT QuotaFiles FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MySQLGetQTASZ   SELECT QuotaSize FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MySQLGetBandwidthUL SELECT ULBandwidth FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf
echo "MySQLGetBandwidthDL SELECT DLBandwidth FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/db/mysql.conf


echo "no" > /etc/pure-ftpd/auth/70pam

echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
echo "yes" > /etc/pure-ftpd/conf/DontResolve
echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir




systemctl enable pure-ftpd-mysql
service pure-ftpd-mysql start


