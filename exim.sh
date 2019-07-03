#!/bin/bash

apt-get remove postfix -y
apt-get remove exim -y


service sendmail stop
systemctl disable sendmail

apt-get install spf-tools-perl -y


perl -MCPAN -e 'install Mail::SPF'
perl -MCPAN -e 'install Mail::SPF::Test'
perl -MCPAN -e 'install Mail::SPF::Query'


apt-get install exim4-daemon-heavy -y

cd /etc/exim4

mkdir -p /var/www/html/mail/domains
touch /var/www/html/mail/whitelist
touch /var/www/html/mail/blacklist
touch /etc/exim4/system_filter

rm -fr /etc/exim4/update-exim4.conf.conf
rm -fr /etc/exim4/exim4.conf.template
rm -fr /etc/exim4/exim4.conf.localmacros
rm -fr /etc/exim4/conf.d


openssl req -batch -nodes -x509 -newkey rsa:2048 -keyout privkey.key -out certificate.crt -days 365

chown root.Debian-exim /etc/exim4/certificate.crt
chown root.Debian-exim /etc/exim4/privkey.key
chmod 644 /etc/exim4/certificate.crt
chmod 644 /etc/exim4/privkey.key


cd /etc
rm -fr aliases
/usr/bin/wget https://api.webcp.io/downloads/aliases

/tmp/exim_conf.sh

