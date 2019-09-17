#!/bin/bash

apt-get install wget -y

wget https://api.webcp.io/downloads/2.0.0/setup/init.sh
chmod 755 /tmp/init.sh
/tmp/init.sh
rm -fr /tmp/init.sh


wget https://api.webcp.io/downloads/2.0.0/setup/webcp-scripts.sh
chmod 755 /tmp/webcp-scripts.sh
/tmp/webcp-scripts.sh
rm -fr /tmp/webcp-scripts.sh

Password=`/usr/webcp/get_password.sh`


wget https://api.webcp.io/downloads/2.0.0/setup/php72.sh
chmod 755 /tmp/php72.sh
/tmp/php72.sh
rm -fr /tmp/php72.sh

wget https://api.webcp.io/downloads/2.0.0/setup/php56.sh
chmod 755 /tmp/php56.sh
/tmp/php56.sh
rm -fr /tmp/php56.sh


wget https://api.webcp.io/downloads/2.0.0/setup/nginx.sh
wget https://api.webcp.io/downloads/2.0.0/setup/nginx_conf.sh
chmod 755 /tmp/nginx.sh
/tmp/nginx.sh
rm -fr /tmp/nginx.sh

wget https://api.webcp.io/downloads/2.0.0/setup/mysql.sh
chmod 755 /tmp/mysql.sh
/tmp/mysql.sh $Password
rm -fr /tmp/mysql.sh

wget https://api.webcp.io/downloads/2.0.0/setup/sshd.sh
chmod 755 /tmp/sshd.sh
/tmp/sshd.sh
rm -fr /tmp/sshd.sh

wget https://api.webcp.io/downloads/2.0.0/setup/exim.sh   
wget https://api.webcp.io/downloads/2.0.0/setup/exim_conf.sh   
chmod 755 /tmp/exim.sh   
/tmp/exim.sh   
rm -fr /tmp/exim.sh   

wget https://api.webcp.io/downloads/2.0.0/setup/dovecot.sh  
wget https://api.webcp.io/downloads/2.0.0/setup/dovecot_conf.sh  
chmod 755 /tmp/dovecot.sh  
/tmp/dovecot.sh  
rm -fr /tmp/dovecot.sh  

wget https://api.webcp.io/downloads/2.0.0/setup/clam.sh     
chmod 755 /tmp/clam.sh     
/tmp/clam.sh     
rm -fr /tmp/clam.sh     

wget https://api.webcp.io/downloads/2.0.0/setup/spamassassin.sh
chmod 755 /tmp/spamassassin.sh
/tmp/spamassassin.sh
rm -fr /tmp/spamassassin.sh

wget https://api.webcp.io/downloads/2.0.0/setup/ftp.sh
chmod 755 /tmp/ftp.sh
/tmp/ftp.sh $Password
rm -fr /tmp/ftp.sh



wget https://api.webcp.io/downloads/2.0.0/setup/fail2ban.sh
wget https://api.webcp.io/downloads/2.0.0/setup/fail2ban_conf.sh
chmod 755 /tmp/fail2ban.sh
/tmp/fail2ban.sh
rm -fr /tmp/fail2ban.sh

wget https://api.webcp.io/downloads/2.0.0/setup/bind.sh
chmod 755 /tmp/bind.sh
/tmp/bind.sh
rm -fr /tmp/bind.sh

wget https://api.webcp.io/downloads/2.0.0/setup/phpmyadmin.sh
chmod 755 /tmp/phpmyadmin.sh
/tmp/phpmyadmin.sh
rm -fr /tmp/phpmyadmin.sh

wget https://api.webcp.io/downloads/2.0.0/setup/rainloop.sh 
chmod 755 /tmp/rainloop.sh 
/tmp/rainloop.sh $Password
rm -fr /tmp/rainloop.sh

wget https://api.webcp.io/downloads/2.0.0/setup/quota.sh  
chmod 755 /tmp/quota.sh    
/tmp/quota.sh    
rm -fr /tmp/quota.sh      


wget https://api.webcp.io/downloads/2.0.0/setup/webcp-www.sh   
chmod 755 /tmp/webcp-www.sh   
/tmp/webcp-www.sh   
rm -fr /tmp/webcp-www.sh   

wget https://api.webcp.io/downloads/2.0.0/setup/logrotate.sh   
chmod 755 /tmp/logrotate.sh  
/tmp/logrotate.sh
rm -fr /tmp/logrotate.sh  

wget https://api.webcp.io/downloads/2.0.0/setup/final.sh   
chmod 755 /tmp/final.sh   
/tmp/final.sh   
rm -fr /tmp/final.sh   


rm -fr /tmp/installer.sh


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
echo "          *       You can now go to http://YOUR_IP/webcp and login with           *"
echo "          *       username 'admin@admin.admin' and password 'adminadmin'          *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *       ssh login must be on port 7533 and root cannot login.           *"
echo "          *                                                                       *"
echo "          *                                                                       *"
echo "          *************************************************************************"


reboot now

