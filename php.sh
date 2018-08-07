#!/bin/bash


##################
#
# PHP
#
##################

apt-get install php-fpm php-mysql php-xml php-gd php-zip php-curl php-mbstring php-mcrypt php-xml php-soap php-imap php-opcache -y
apt-get install php-pear -y

apt-get install php-auth php-intl php-mail-mime php-mail-mimedecode php-net-smtp php-net-socket php-cli php-common php-curl php-fpm php-gd php-imap php-intl php-json php-mbstring php-mcrypt php-mysql php-opcache php-readline php-soap php-xml php-zip -y


pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime Mail_mimeDecode

echo "[PHP]" > /etc/php/7.0/fpm/php.ini 
echo "engine = On" >> /etc/php/7.0/fpm/php.ini 
echo "expose_php = Off" >> /etc/php/7.0/fpm/php.ini 
echo "zend_extension = /etc/php/7.0/ioncube_loader_lin_7.0.so" >> /etc/php/7.0/fpm/php.ini 
echo "max_execution_time = 5" >> /etc/php/7.0/fpm/php.ini 
echo "memory_limit = -1" >> /etc/php/7.0/fpm/php.ini 
echo "error_reporting = E_ALL & ~E_DEPRECATED" >> /etc/php/7.0/fpm/php.ini 
echo "display_errors = Off" >> /etc/php/7.0/fpm/php.ini 
echo "display_startup_errors = Off" >> /etc/php/7.0/fpm/php.ini 
echo "html_errors = Off" >> /etc/php/7.0/fpm/php.ini 
echo "default_socket_timeout = 5" >> /etc/php/7.0/fpm/php.ini 
echo "" >> /etc/php/7.0/fpm/php.ini 
echo "file_uploads = On" >> /etc/php/7.0/fpm/php.ini 
echo "upload_tmp_dir = /tmp/php" >> /etc/php/7.0/fpm/php.ini 
echo "upload_max_filesize = 50M" >> /etc/php/7.0/fpm/php.ini 
echo "post_max_size = 50M" >> /etc/php/7.0/fpm/php.ini 
echo "max_file_uploads = 20" >> /etc/php/7.0/fpm/php.ini 
echo "" >> /etc/php/7.0/fpm/php.ini 
echo "date.timezone = 'Africa/Johannesburg'" >> /etc/php/7.0/fpm/php.ini 
echo "" >> /etc/php/7.0/fpm/php.ini 
echo "cgi.fix_pathinfo = 0" >> /etc/php/7.0/fpm/php.ini 
echo "" >> /etc/php/7.0/fpm/php.ini 
echo "[opcache]" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.enable=1" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.revalidate_freq=5" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.validate_timestamps=1" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.max_accelerated_files=7963" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.memory_consumption=192" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.interned_strings_buffer=16" >> /etc/php/7.0/fpm/php.ini 
echo "opcache.fast_shutdown=1" >> /etc/php/7.0/fpm/php.ini 


cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip
unzip ioncube_loaders_lin_x86-64.zip
cp /tmp/ioncube/ioncube_loader_lin_7.0.so /etc/php/7.0



service php7.0-fpm restart



