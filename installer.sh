#!/bin/bash

apt-get install wget -y

wget http://api.webcp.pw/downloads/2.0.0/1-init.sh
chmod 755 /tmp/1-init.sh
/tmp/1-init.sh
rm -fr /tmp/1-init.sh

wget http://api.webcp.pw/downloads/2.0.0/2-nginx.sh
chmod 755 /tmp/2-nginx.sh
/tmp/2-nginx.sh
rm -fr /tmp/2-nginx.sh

wget http://api.webcp.pw/downloads/2.0.0/3-php.sh
chmod 755 /tmp/3-php.sh
/tmp/3-php.sh
rm -fr /tmp/3-php.sh

wget http://api.webcp.pw/downloads/2.0.0/4-mysql.sh
chmod 755 /tmp/4-mysql.sh
/tmp/4-mysql.sh
rm -fr /tmp/4-mysql.sh

wget http://api.webcp.pw/downloads/2.0.0/5-sshd.sh
chmod 755 /tmp/5-sshd.sh
/tmp/5-sshd.sh
rm -fr /tmp/5-sshd.sh

wget http://api.webcp.pw/downloads/2.0.0/6-exim.sh   
chmod 755 /tmp/6-exim.sh   
/tmp/6-exim.sh   
rm -fr /tmp/6-exim.sh   

wget http://api.webcp.pw/downloads/2.0.0/7-dovecot.sh  
chmod 755 /tmp/7-dovecot.sh  
/tmp/7-dovecot.sh  
rm -fr /tmp/7-dovecot.sh  

wget http://api.webcp.pw/downloads/2.0.0/8-clam.sh     
chmod 755 /tmp/8-clam.sh     
/tmp/8-clam.sh     
rm -fr /tmp/8-clam.sh     

wget http://api.webcp.pw/downloads/2.0.0/9-spamassassin.sh
chmod 755 /tmp/9-spamassassin.sh
/tmp/9-spamassassin.sh
rm -fr /tmp/9-spamassassin.sh

wget http://api.webcp.pw/downloads/2.0.0/10-ftp.sh
chmod 755 /tmp/10-ftp.sh
/tmp/10-ftp.sh
rm -fr /tmp/10-ftp.sh



wget http://api.webcp.pw/downloads/2.0.0/11-fail2ban.sh
chmod 755 /tmp/11-fail2ban.sh
/tmp/11-fail2ban.sh
rm -fr /tmp/11-fail2ban.sh

wget http://api.webcp.pw/downloads/2.0.0/12-bind.sh
chmod 755 /tmp/12-bind.sh
/tmp/12-bind.sh
rm -fr /tmp/12-bind.sh

wget http://api.webcp.pw/downloads/2.0.0/13-phpmyadmin.sh
chmod 755 /tmp/13-phpmyadmin.sh
/tmp/13-phpmyadmin.sh
rm -fr /tmp/13-phpmyadmin.sh

wget http://api.webcp.pw/downloads/2.0.0/14-rainloop.sh 
chmod 755 /tmp/14-rainloop.sh 
/tmp/14-rainloop.sh 
rm -fr /tmp/14-rainloop.sh

wget http://api.webcp.pw/downloads/2.0.0/15-quota.sh  
chmod 755 /tmp/15-quota.sh    
/tmp/15-quota.sh    
rm -fr /tmp/15-quota.sh      

wget http://api.webcp.pw/downloads/2.0.0/16-final.sh   
chmod 755 /tmp/16-final.sh   
/tmp/16-final.sh   
rm -fr /tmp/16-final.sh   

rm -fr /tmp/installer.sh
