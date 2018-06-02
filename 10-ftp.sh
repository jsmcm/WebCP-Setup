#!/bin/bash

apt-get install pure-ftpd -y


cd /etc/pure-ftpd
rm -fr *


echo "MYSQLSocket     /var/lib/mysql/mysql.sock" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLUser       root" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLPassword   $DatabasePassword" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLDatabase   cpadmin" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLCrypt      md5" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLGetPW      SELECT Password FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess=\"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLGetUID     SELECT Uid FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLGetGID     SELECT Gid FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MYSQLGetDir     SELECT Dir FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MySQLGetQTAFS   SELECT QuotaFiles FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MySQLGetQTASZ   SELECT QuotaSize FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MySQLGetBandwidthUL SELECT ULBandwidth FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf
echo "MySQLGetBandwidthDL SELECT DLBandwidth FROM ftpd WHERE User=\"\\L\" AND status=\"1\" AND (ipaccess = \"*\" OR ipaccess LIKE \"\\R\")" >> /etc/pure-ftpd/pureftpd-mysql.conf



echo "ChrootEveryone              	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "BrokenClientsCompatibility  	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MaxClientsNumber            	50" >> /etc/pure-ftpd/pure-ftpd.conf
echo "Daemonize                   	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MaxClientsPerIP            	8" >> /etc/pure-ftpd/pure-ftpd.conf
echo "VerboseLog                  	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "DisplayDotFiles             	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AnonymousOnly               	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "NoAnonymous                 	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "SyslogFacility             	ftp" >> /etc/pure-ftpd/pure-ftpd.conf
echo "DontResolve                 	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MaxIdleTime                 	15" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MySQLConfigFile               	/etc/pure-ftpd/pureftpd-mysql.conf" >> /etc/pure-ftpd/pure-ftpd.conf
echo "PAMAuthentication             	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "LimitRecursion              	7500 8" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AnonymousCanCreateDirs      	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MaxLoad                     	4" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AntiWarez                   	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "Umask                       	133:022" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MinUID                      	500" >> /etc/pure-ftpd/pure-ftpd.conf
echo "UseFtpUsers 			no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AllowUserFXP                	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AllowAnonymousFXP           	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "ProhibitDotFilesWrite       	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "ProhibitDotFilesRead        	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AutoRename                  	no" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AnonymousCantUpload         	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "AltLog                     	clf:/var/log/pureftpd.log" >> /etc/pure-ftpd/pure-ftpd.conf
echo "CreateHomeDir               	yes" >> /etc/pure-ftpd/pure-ftpd.conf
echo "MaxDiskUsage               	99" >> /etc/pure-ftpd/pure-ftpd.conf
echo "CustomerProof              	yes" >> /etc/pure-ftpd/pure-ftpd.conf



systemctl enable pure-ftpd
service pure-ftpd start


