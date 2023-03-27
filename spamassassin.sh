apt-get update
apt-get install -y libmail-dkim-perl libmail-spf-perl libnet-dns-perl libnet-ident-perl libnetaddr-ip-perl libnet-ip-perl libnet-patricia-perl libnet-server-perl libperl5.30 libsys-hostname-long-perl pyzor razor spamassassin spamc -y

systemctl enable spamassassin
service spamassassin start

export PERL_MM_USE_DEFAULT=1
perl -MCPAN -e 'notest install Mail::SpamAssassin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin::Shortcircuit'
perl -MCPAN -e 'install Mail::SpamAssassin::Conf'

systemctl enable spamassassin
service spamassassin start

mkdir -p /etc/mail/spamassassin
cd /etc/mail/spamassassin
rm -fr /etc/mail/spamassasssin/local.cf
wget https://api.webcp.io/downloads/3.0.0/setup/local.cf


