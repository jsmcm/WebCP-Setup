#!/bin/bash

yum install cpan -y

perl -MCPAN -e 'install CPAN'
perl -MCPAN -e 'reload'
perl -MCPAN -e 'install ExtUtils::CBuilder'
perl -MCPAN -e 'install Module::Build'
perl -MCPAN -e 'install Test'
perl -MCPAN -e 'install Archive::Tar'
yum install -y perl-Sys-Syslog
perl -MCPAN -e 'install Test::More'
perl -MCPAN -e 'install IP::Country'
perl -MCPAN -e 'install Net::Ident'
perl -MCPAN -e 'install Net::DNS'
perl -MCPAN -e 'install Net::DNS::Resolver'
perl -MCPAN -e 'install Net::DNS::Resolver::Programmable'

yum install wget net-tools unzip zip tar -y
/usr/bin/yum install gcc make -y

yum install openssl openssl-devel -y


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








echo "127.0.0.1 localhost.localdomain localhost localhost4.localdomain4 localhost4" > /etc/hosts
echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
echo "$IP $HostName" >> /etc/hosts

