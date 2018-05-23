
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


