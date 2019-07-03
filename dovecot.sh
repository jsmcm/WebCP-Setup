#!/bin/bash

apt-get install dovecot-core dovecot-imapd dovecot-pop3d -y

mkdir /etc/dovecot/ssl
chown dovecot.dovecot /etc/dovecot/ssl

cd /usr/share/dovecot
./mkcert.sh


if [ ! -d /var/log/dovecot ] 
then
	mkdir /var/log/dovecot
	chown dovecot.dovecot /var/log/dovecot -R
	chmod 755 /var/log/dovecot -R
fi

/tmp/dovecot_conf.sh


