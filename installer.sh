#!/bin/bash

apt-get install wget -y

wget http://api.webcp.pw/downloads/2.0.0/setup/init.sh
chmod 755 /tmp/init.sh
/tmp/init.sh
rm -fr /tmp/init.sh


wget http://api.webcp.pw/downloads/2.0.0/setup/webcp-scripts.sh
chmod 755 /tmp/webcp-scripts.sh
/tmp/webcp-scripts.sh
rm -fr /tmp/webcp-scripts.sh

Password=`/usr/webcp/get_password.sh`

wget http://api.webcp.pw/downloads/2.0.0/setup/nginx.sh
chmod 755 /tmp/nginx.sh
/tmp/nginx.sh
rm -fr /tmp/nginx.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/php.sh
chmod 755 /tmp/php.sh
/tmp/php.sh
rm -fr /tmp/php.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/mysql.sh
chmod 755 /tmp/mysql.sh
/tmp/mysql.sh $Password
rm -fr /tmp/mysql.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/sshd.sh
chmod 755 /tmp/sshd.sh
/tmp/sshd.sh
rm -fr /tmp/sshd.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/exim.sh   
chmod 755 /tmp/exim.sh   
/tmp/exim.sh   
rm -fr /tmp/exim.sh   

wget http://api.webcp.pw/downloads/2.0.0/setup/dovecot.sh  
chmod 755 /tmp/dovecot.sh  
/tmp/dovecot.sh  
rm -fr /tmp/dovecot.sh  

wget http://api.webcp.pw/downloads/2.0.0/setup/clam.sh     
chmod 755 /tmp/clam.sh     
/tmp/clam.sh     
rm -fr /tmp/clam.sh     

wget http://api.webcp.pw/downloads/2.0.0/setup/spamassassin.sh
chmod 755 /tmp/spamassassin.sh
/tmp/spamassassin.sh
rm -fr /tmp/spamassassin.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/ftp.sh
chmod 755 /tmp/ftp.sh
/tmp/ftp.sh $Password
rm -fr /tmp/ftp.sh



wget http://api.webcp.pw/downloads/2.0.0/setup/fail2ban.sh
chmod 755 /tmp/fail2ban.sh
/tmp/fail2ban.sh
rm -fr /tmp/fail2ban.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/bind.sh
chmod 755 /tmp/bind.sh
/tmp/bind.sh
rm -fr /tmp/bind.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/phpmyadmin.sh
chmod 755 /tmp/phpmyadmin.sh
/tmp/phpmyadmin.sh
rm -fr /tmp/phpmyadmin.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/rainloop.sh 
chmod 755 /tmp/rainloop.sh 
/tmp/rainloop.sh $Password
rm -fr /tmp/rainloop.sh

wget http://api.webcp.pw/downloads/2.0.0/setup/quota.sh  
chmod 755 /tmp/quota.sh    
/tmp/quota.sh    
rm -fr /tmp/quota.sh      

wget http://api.webcp.pw/downloads/2.0.0/setup/final.sh   
chmod 755 /tmp/final.sh   
/tmp/final.sh   
rm -fr /tmp/final.sh   


wget http://api.webcp.pw/downloads/2.0.0/setup/webcp-www.sh   
chmod 755 /tmp/webcp-www.sh   
/tmp/webcp-www.sh   
rm -fr /tmp/webcp-www.sh   


rm -fr /tmp/installer.sh