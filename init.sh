#!/bin/bash

#MYSQL_PASSWORD=`date +%s | sha256sum | base64 | head -c 10 ; echo`


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
echo "Using HostName: '$HostName'"




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

echo "$UserName" > /tmp/webcp_username
echo "$HostName" > /etc/hostname


apt-get remove httpd-devel httpd -y
apt-get remove apache2 -y
apt-get remove mod_suphp php php-cli php-common php-gd gd php-mbstring php-mcrypt php-xml php-xmlrpc php-soap -y
apt-get remove mod_security -y
apt-get remove php-soap -y
apt-get remove postfix -y
apt-get remove exim -y
rm -fr /etc/httpd
rm -fr /etc/apache2

apt-get update -y
apt-get install wget net-tools unzip zip tar -y
apt-get install gcc make -y
apt-get install git -y
apt-get install git-flow -y

#wget -O /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
#chmod 755 /usr/local/bin/jq

apt-get install mcrypt -y

apt-get install pkg-config -y
apt-get install libpcre3 libpcre3-dev -y
apt-get install zlib1g-dev -y
apt-get install ssl-cert -y

apt-get install pcre pcre-devel -y
apt-get install gdbm gdbm-devel -y
apt-get install ldb-tools libldb-devel libldb -y
apt-get install db4 db4-devel db4-utils compat-db43 -y
apt-get install pam pam-devel rpm-build compat-db -y
apt-get install openldap openldap-clients openldap-devel compat-openldap -y

apt-get install curl -y

make-ssl-cert generate-default-snakeoil

apt-get install openssl -y
#cd /tmp
#git clone https://github.com/openssl/openssl.git
#cd openssl
#./config
#make
#make install
#echo "/usr/local/lib" >> /etc/ld.so.conf
#ldconfig








export PERL_MM_USE_DEFAULT=1
apt-get install cpan -y
apt-get install perl perl-devel -y
apt-get install -y perl-Sys-Syslog

perl -MCPAN -e 'install CPAN'
perl -MCPAN -e 'reload'
perl -MCPAN -e 'install Test'
perl -MCPAN -e 'install Module::Build'
perl -MCPAN -e 'install ExtUtils::CBuilder'
perl -MCPAN -e 'install Test::More'
perl -MCPAN -e 'install IP::Country'
perl -MCPAN -e 'install Net::Ident'
perl -MCPAN -e 'install Net::DNS'
perl -MCPAN -e 'install Net::DNS::Resolver'
perl -MCPAN -e 'install Net::DNS::Resolver::Programmable'
perl -MCPAN -e 'install Archive::Tar'
perl -MCPAN -e 'DBI'


apt-get install openssl openssl-devel -y


apt-get install libxml2 libxml2-devel curl-devel -y

apt-get install mlocate -y
apt-get install quota -y
apt-get install man -y
#apt-get install bind.x86_64 bind-libs.x86_64 bind-utils -y
apt-get install mutt -y




apt-get update -y

apt-get install composer -y
apt-get install ufw -y
apt-get install virtualenv -y

apt-get install expect -y

apt-get install snapd -y
snap install --classic certbot






mkdir -p /var/www/html/

echo "DATABASE_NAME=\"cpadmin\"" > /var/www/html/config.php
echo "DATABASE_HOST=\"localhost\"" >> /var/www/html/config.php
echo "DATABASE_USER=\"root\"" >> /var/www/html/config.php
echo "DATABASE_PASSWORD=\"$Password\"" >> /var/www/html/config.php
          


useradd -m -s /bin/bash -p "$(openssl passwd -1 $Password)" $UserName


ufw default deny incoming
ufw default allow outgoing

ufw allow 21/tcp
ufw allow 25/tcp
ufw allow 53/udp
ufw allow 53/tcp
ufw allow 80/tcp
ufw allow 110/tcp
ufw allow 143/tcp
ufw allow 443/tcp
ufw allow 465/tcp

ufw allow 587/tcp
ufw allow 995/tcp
ufw allow 993/tcp

ufw allow 2052/tcp
ufw allow 2053/tcp
ufw allow 2082/tcp
ufw allow 2083/tcp
ufw allow 2086/tcp
ufw allow 2087/tcp
ufw allow 2095/tcp
ufw allow 2096/tcp

ufw allow 3306/tcp
ufw allow 7533/tcp
ufw allow 8443/tcp
ufw allow 8880/tcp

ufw allow from any to any proto tcp port 6000:7000

