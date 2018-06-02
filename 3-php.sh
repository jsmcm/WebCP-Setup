#!/bin/bash


##################
#
# PHP
#
##################

apt-get install php-fpm php-mysql php-xml php-gd php-zip php-curl php-mbstring php-mcrypt php-xml php-soap php-imap php-opcache -y
apt-get install php-pear -y

apt-get install php-auth php-intl php-mail-mime php-mail-mimedecode php-net-smtp php-net-socket php-cli php-common php-curl php-fpm php-gd php-imap php-intl php-json php-mbstring php-mcrypt php-mysql php-opcache php-readline php-soap php-xml php-zip roundcube-core roundcube-mysql -y


pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime Mail_mimeDecode

service php7.0-fpm restart



