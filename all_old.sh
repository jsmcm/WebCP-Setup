#!/bin/bash

IP=`ip addr show | grep "inet " | grep "global" | awk 'NR>0{ sub(/\/.*/,"",$2); print $2 }' `

IPCount=`echo "$IP" | wc -l`

if [ $IPCount -gt 1 ]
then
        arr=()
        while read -r line; do
                arr+=("$line")
        done <<< "$IP"

        IP=${arr[0]}
fi


MYSQL_PASSWORD=`date +%s | sha256sum | base64 | head -c 10 ; echo`


echo "		****************************************************************		"
echo "		*							       *		"
echo "		*	FIRST STEPS...					       *		"
echo "		*							       *		"
echo "		****************************************************************		"

HostNameBuffer=`hostname`
HostName=""
echo $HostNameBuffer

echo "Please enter this server's FQDN: $HostNameBuffer"

read HostName

if [ -z "$HostName" ]
then
        # entered nothing, use buffer..
        HostName="$HostNameBuffer"
fi

 



Password=""
Password1="."
UserName=""

while [ -z "$UserName" ]
do
        echo ""
        echo ""
        echo ""
        echo "Please create a new user to log into SSH with..."
        echo "Enter new username: "
        read UserName

        if [ -z "$UserName" ]
        then
                echo "PLEASE ENTER A USERNAME"
        fi
done

while [ "$Password" != "$Password1" ]
do
        Password=""
        Password1=""

        while [ -z "$Password" ]
        do
                echo "Password for $UserName: "
		echo "NOTE: it will also be your MySQL root password, changeable in WebCP"

                read Password

                if [ -z "$Password" ]
                then
                        echo "PLEASE ENTER A PASSWORD"
                fi
        done

        while [ -z "$Password1" ]
        do
                echo "Re-enter Password: "
                read Password1

                if [ -z "$Password1" ]
                then
                        echo "PLEASE RE-ENTER PASSWORD"
                fi
        done

        if [ "$Password" != "$Password1" ]
        then
                echo "Those passwords don't match. Please try again"
        fi
done

echo "		*************************************************************************"
echo "		*							       		*"	
echo "		*	INSTALLATION STARTING	  					*"	
echo "		*							       		*"	
echo "		*************************************************************************"	
echo "		*									*"
echo "		*	The installation is now starting				*"
echo "		*	This should be over in a few minutes!				*"
echo "		*									*"
echo "		*************************************************************************"


sleep 2


adduser $UserName
echo $Password | passwd $UserName --stdin

yum remove httpd-devel httpd -y
yum remove mod_suphp php php-cli php-common php-gd gd php-mbstring php-mcrypt php-xml php-xmlrpc php-soap -y
yum remove mod_security -y
yum remove php-soap -y
yum remove postfix -y
yum remove exim -y
rm -fr /etc/httpd

yum update -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum -y install epel-release

export PERL_MM_USE_DEFAULT=1
yum install perl perl-devel -y
yum install cpan -y

perl -MCPAN -e 'install CPAN'
perl -MCPAN -e 'reload'
perl -MCPAN -e 'install Test'
perl -MCPAN -e 'install Archive::Tar'
yum install -y perl-Sys-Syslog
perl -MCPAN -e 'install Module::Build'
perl -MCPAN -e 'install ExtUtils::CBuilder'
perl -MCPAN -e 'install Test::More'
perl -MCPAN -e 'install IP::Country'
perl -MCPAN -e 'install Net::Ident'
perl -MCPAN -e 'install Net::DNS'
perl -MCPAN -e 'install Net::DNS::Resolver'
perl -MCPAN -e 'install Net::DNS::Resolver::Programmable'

yum install wget net-tools unzip zip tar -y
/usr/bin/yum install gcc make -y

yum install openssl openssl-devel -y


/usr/bin/yum install libxml2 libxml2-devel curl-devel -y

yum install unzip zip tar -y
yum install mlocate -y
yum install quota -y
yum install man -y
yum install bind.x86_64 bind-libs.x86_64 bind-utils -y
yum install mutt -y


yum install pcre pcre-devel -y
yum install gdbm gdbm-devel -y
yum install ldb-tools libldb-devel libldb -y
yum install db4 db4-devel db4-utils compat-db43 -y
yum install pam pam-devel rpm-build compat-db -y
yum install openldap openldap-clients openldap-devel compat-openldap -y

yum install yum-plugin-protectbase.noarch -y

yum install git -y


yum update -y

##################
#
# SELINUX
#
##################

if [ -f "/etc/selinux/config" ]
then
        echo "SELINUX=disabled" > /etc/selinux/config
        echo "SELINUXTYPE=targeted" >> /etc/selinux/config
fi




##################
#
# APACHE / PHP
#
##################

yum install httpd-devel httpd -y
yum install php70 php70-php-cli php70-php-common php70-php-gd php70-php-mbstring php70-php-mcrypt php70-php-xml php70-php-xmlrpc php70-php-soap php70-php-imap php70-php-fpm php70-php-opcache -y
yum install mod_security -y



cd /tmp
mkdir webcp
chown apache.apache webcp
chmod 770 webcp

cd /etc
rm -fr php.ini
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/php.zip
unzip -o php.zip
rm -fr php.zip

cd /etc/httpd/
mkdir /etc/httpd/conf/vhosts

rm -fr conf/httpd.conf
rm -fr conf.d/mod_security.conf
rm -fr modsecurity.d

/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/httpd.zip
unzip -o httpd.zip
rm -fr httpd.zip
cd conf
cat httpd.tmp | sed "s/NameVirtualHost \*/NameVirtualHost ${IP}/g" > httpd.conf
rm -fr httpd.tmp





cd /var/www/html
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/webcp.zip
unzip webcp.zip
rm -fr webcp.zip
chown apache.apache webcp -R
chmod 755 webcp -R

cd /var/www/html
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/phpmyadmin.zip
unzip phpmyadmin.zip
rm -fr phpmyadmin.zip
chown apache.apache phpmyadmin -R
chmod 755 phpmyadmin -R

cd /var/www/html
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/squirrelmail.zip
unzip squirrelmail.zip
rm -fr squirrelmail.zip
chown apache.apache squirrelmail -R
chmod 755 squirrelmail -R

cd /var/www/html
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/bandwidth.zip
unzip bandwidth.zip
rm -fr bandwidth.zip
chown apache.apache bandwidth -R
chmod 755 bandwidth -R



echo "<?php" > /var/www/html/index.php
echo "" >> /var/www/html/index.php
echo "if(isset(\$_SERVER[\"HTTPS\"]))" >> /var/www/html/index.php
echo "{" >> /var/www/html/index.php
        echo "if( strtolower(trim(\$_SERVER[\"HTTPS\"])) == \"on\" )" >> /var/www/html/index.php
        echo "{" >> /var/www/html/index.php
                echo "header(\"location: http://\".\$_SERVER[\"HTTP_HOST\"]);" >> /var/www/html/index.php
                echo "exit();" >> /var/www/html/index.php
        echo "}" >> /var/www/html/index.php
echo "}" >> /var/www/html/index.php
echo "?>" >> /var/www/html/index.php
echo "" >> /var/www/html/index.php
echo "" >> /var/www/html/index.php
echo "" >> /var/www/html/index.php
echo "<html>" >> /var/www/html/index.php
echo "<body>" >> /var/www/html/index.php
echo "This is the default web site...." >> /var/www/html/index.php
echo "<p>To create new websites, please login to the <a href=\"http://<?php print \$_SERVER[\"SERVER_ADDR\"]; ?>:10025\">web control panel</a>" >> /var/www/html/index.php
echo "</body>" >> /var/www/html/index.php
echo "</html>" >> /var/www/html/index.php






echo "<?php" > /var/www/html/webcp/includes/Variables.inc.php
echo "global \$DatabaseName;" >> /var/www/html/webcp/includes/Variables.inc.php
echo "\$DatabaseName = \"cpadmin\";" >> /var/www/html/webcp/includes/Variables.inc.php
echo "" >> /var/www/html/webcp/includes/Variables.inc.php
echo "global \$DatabaseUserName;" >> /var/www/html/webcp/includes/Variables.inc.php
echo "\$DatabaseUserName = \"root\";" >> /var/www/html/webcp/includes/Variables.inc.php
echo "" >> /var/www/html/webcp/includes/Variables.inc.php
echo "global \$DatabasePassword;" >> /var/www/html/webcp/includes/Variables.inc.php
echo "\$DatabasePassword = \"$Password\";" >> /var/www/html/webcp/includes/Variables.inc.php
echo "" >> /var/www/html/webcp/includes/Variables.inc.php
echo "global \$DatabaseHost;" >> /var/www/html/webcp/includes/Variables.inc.php
echo "\$DatabaseHost = \"localhost\";" >> /var/www/html/webcp/includes/Variables.inc.php
echo "?>" >> /var/www/html/webcp/includes/Variables.inc.php



cd /etc/
rm -fr crontab
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/crontab



cd /usr/local
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/awstats.zip
unzip -o awstats.zip
rm -fr awstats.zip
mkdir /var/lib/awstats

cd /etc/httpd

/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/ioncube_loader_lin_7.0.so



cd /var/www/cgi-bin
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/cgi-bin.zip
unzip cgi-bin.zip
rm -fr cgi-bin.zip

cd /etc/skel
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/skel.zip
unzip skel.zip
rm -fr skel.zip

cd /usr
mkdir webcp
cd /usr/webcp
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/scripts.zip
unzip scripts.zip
rm -fr scripts.zip



echo "$Password" > /usr/webcp/password


systemctl enable httpd


##################
#
# SSH CONFIG
#
##################

cd /etc/ssh
rm -fr /etc/ssh/sshd_config
wget http://webcp.pw/api/downloads/2.0.0/sshd_config


service sshd restart



#!/bin/bash

##################
#
# MySQL
#
##################
yum install sqlite sqlite-devel -y

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update -y

yum install mysql proftpd-mysql mysql-connector-odbc mysql-devel mysql-libs dovecot-mysql php70-php-mysql mysql-server -y

systemctl start mysqld

/usr/bin/mysqladmin -u root password '$Password'



cd /tmp
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/cpadmin.sql


/usr/bin/mysql -u root -p$Password < cpadmin.sql
rm -fr cpadmin.sql

$(mysql -u root -p$Password -se "DROP DATABASE test;")

#!/bin/bash

yum install pure-ftpd -y

service pure-ftpd start

cd /etc/pure-ftpd
rm -fr *

wget http://webcp.pw/api/downloads/2.0.0/pureftpd.zip

unzip pureftpd.zip
rm -fr pureftpd.zip

cat pureftpd-mysql.tmp | sed "s/WEBCP_PASSWORD/$Password/g" > pureftpd-mysql.conf
rm -fr pureftpd-mysql.tmp




yum remove postfix -y
yum remove exim -y



/etc/init.d/sendmail stop
chkconfig sendmail off



yum install exim-mysql -y
yum install libspf2-devel libspf2 -y


perl -MCPAN -e 'install Mail::SPF'
perl -MCPAN -e 'install Mail::SPF::Test'
perl -MCPAN -e 'install Mail::SPF::Query'


yum install pyzor perl-Razor-Agent -y

yum install spamassassin -y


pyzor --homedir /etc/mail/spamassassin/.pyzor discover
razor-admin -home=/etc/mail/spamassassin/.razor -create
razor-admin -home=/etc/mail/spamassassin/.razor -discover
razor-admin -home=/etc/mail/spamassassin/.razor -register -user root@not-real






cd /tmp
wget http://api.webcp.pw/downloads/2.0.0/exim-src.zip
unzip exim-src.zip
cd /tmp/exim-4.90
make
make install

rm -fr /tmp/exim-4.90
rm -fr /tmp/exim-src.zip

cd /etc/exim

openssl req -batch -nodes -x509 -newkey rsa:2048 -keyout privkey.key -out certificate.crt -days 365


/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/exim-conf.zip
unzip -o exim-conf.zip
rm -fr exim-conf.zip

cat exim.tmp | sed "s/WEBCP_PASSWORD/PASSWORD/g" > exim.conf
rm -fr exim.tmp

mkdir /var/log/clamav
chown clamscan.clamscan /var/log/clamav


yum install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd -y

cd /etc/clamd.d
wget http://api.webcp.pw/downloads/2.0.0/clamd.zip
unzip clamd.zip
mv ./clam\@scan.service /usr/lib/systemd/system/clamd
mv ./clam.service /usr/lib/systemd/system/clamd
rm -fr clamd.zip

mv /usr/lib/systemd/system/clamd@.service /usr/lib/systemd/system/clamd.service

systemctl enable clamd.service


usermod -a -G exim clamupdate
usermod -a -G exim clamscan
usermod -a -G mail clamupdate
usermod -a -G mail clascan
gpasswd -a clam exim

service clamd start

chmod 770 /var/spool/exim -R

systemctl enable spamassassin
service spamassassin start

cd /etc
rm -fr aliases
/usr/bin/wget http://webcp.pw/api/downloads/aliases









#!/bin/bash


yum install dovecot dovecot-devel dovecot-mysql -y

cd /etc/dovecot
/usr/bin/wget http://webcp.pw/api/downloads/2.0.0/dovecot_conf.zip
unzip -o dovecot_conf.zip 
rm -fr dovecot_conf.zip
cat dovecot-sql.tmp | sed "s/WEBCP_PASSWORD/$Password/g" > dovecot-sql.conf
rm -fr dovecot-sql.tmp

mkdir /var/log/dovecot
chown dovecot.dovecot /var/log/dovecot -R
chmod 755 /var/log/dovecot -R


#!/bin/bash


yum install iptables iptables-ipv6 -y

cd /tmp
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh
cd /tmp
rm -fr csf*

cd /etc/csf
rm -fr csf.conf
wget http://webcp.pw/api/downloads/2.0.0/csf.conf

cd /usr/local/csf/bin
rm -fr regex.custom.pm
wget http://webcp.pw/api/downloads/2.0.0/regex.custom.pm

service lfd restart
csf -r

cd /tmp
wget https://solidshellsecurity.com/_public/scripts/rkhunter_install.sh -v && chmod u+x rkhunter_install.sh && ./rkhunter_install.sh --time d
rm -fr /tmp/rkhunter_install.sh


##################
#
# START STUFF
#
##################

systemctl enable crond
systemctl enable named

echo "127.0.0.1 localhost.localdomain localhost localhost4.localdomain4 localhost4" > /etc/hosts
echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
echo "$IP $HostName" >> /etc/hosts

service exim stop
rm -fr /var/spool/exim/db/*


service named restart
service sshd restart
service httpd restart
service exim restart
service dovecot restart
service mysqld restart
service pure-ftpd restart
service crond restart

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

echo "          *************************************************************************"
echo "          *                                                                       *"
echo "          *       INSTALLATION COMPLETE!                                          *"
echo "          *                                                                       *"
echo "          *************************************************************************"
echo "          *                                                                       *"
echo "          *       You can now go to http://${IP}/webcp and login with             *"
echo "          *       username 'admin@admin.admin' and password 'adminadmin'          *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *       ssh login must be on port 7533 and root cannot login.           *"
echo "          *       eg:                                                             *"
echo "          *       ssh $HostName -l $UserName -p 7533                              *"
echo "          *       or:                                                             *"
echo "          *       ssh $IP -l $UserName -p 7533                                    *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *************************************************************************"


