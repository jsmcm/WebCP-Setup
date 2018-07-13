#!/bin/bash

apt-get install composer -y


cd /var/www/html/
composer create-project phpmyadmin/phpmyadmin
cd /var/www/html/phpmyadmin

composer update --no-dev

secret=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`

echo "<?php" > /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['blowfish_secret'] = '$secret';" >> /var/www/html/phpmyadmin/config.inc.php
echo "" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$i = 0;" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$i++;" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][\$i]['auth_type'] = 'cookie';" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][\$i]['host'] = 'localhost';" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][\$i]['compress'] = false;" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][\$i]['AllowNoPassword'] = false;" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][\$i]['AllowRoot'] = false;" >> /var/www/html/phpmyadmin/config.inc.php
echo "" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['UploadDir'] = '';" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['SaveDir'] = '';" >> /var/www/html/phpmyadmin/config.inc.php
echo "\$cfg['AuthLog'] = '/var/log/phpmyadmin.log';" >> /var/www/html/phpmyadmin/config.inc.php


touch /var/log/phpmyadmin.log
chown www-data.www-data /var/log/phpmyadmin.log

chown www-data.www-data /var/www/html/phpmyadmin -R
