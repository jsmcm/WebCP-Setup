#!/bin/bash

apt-get install dovecot-core dovecot-imapd dovecot-pop3d -y

cd /usr/share/dovecot
./mkcert.sh


if [ ! -d /var/log/dovecot ] 
then
	mkdir /var/log/dovecot
	chown dovecot.dovecot /var/log/dovecot -R
	chmod 755 /var/log/dovecot -R
fi


echo "passdb {" > /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "    args = scheme=plain-md5 username_format=%n /var/www/html/mail/domains/%d/dovecot-passwd" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "    driver = passwd-file" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "}" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "userdb {" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "    args =  username_format=%n /var/www/html/mail/domains/%d/dovecot-passwd" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "    driver = passwd-file" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext
echo "}" >> /etc/dovecot/conf.d/auth-passwdfile.conf.ext




echo "auth_mechanisms = plain" > /etc/dovecot/conf.d/10-auth.conf
echo "!include auth-passwdfile.conf.ext" >> /etc/dovecot/conf.d/10-auth.conf


echo "log_path = /var/log/dovecot/main.log" > /etc/dovecot/conf.d/10-logging.conf
echo "auth_verbose = yes" >> /etc/dovecot/conf.d/10-logging.conf
echo "" >> /etc/dovecot/conf.d/10-logging.conf
echo "plugin {" >> /etc/dovecot/conf.d/10-logging.conf
echo "}" >> /etc/dovecot/conf.d/10-logging.conf

echo "protocols = imap pop3" > /etc/dovecot/dovecot.conf
echo "disable_plaintext_auth = no" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "!include /etc/dovecot/conf.d/*.conf" >> /etc/dovecot/dovecot.conf


echo "ssl = yes" > /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_cert = </etc/dovecot/dovecot.pem" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_key = </etc/dovecot/private/dovecot.pem" >> /etc/dovecot/conf.d/10-ssl.conf


echo "namespace inbox {" > /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox Drafts {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Drafts" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox Junk {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Junk" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox Trash {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Trash" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox Archive {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Archive" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox Sent {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Sent" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    mailbox \"Sent Messages\" {" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        auto = create" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "        special_use = \Sent" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "    }" >> /etc/dovecot/conf.d/15-mailboxes.conf
echo "}" >> /etc/dovecot/conf.d/15-mailboxes.conf


