#!/bin/bash

export PERL_MM_USE_DEFAULT=1
perl -MCPAN -e 'install Mail::SpamAssassin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin::Shortcircuit'
perl -MCPAN -e 'install Mail::SpamAssassin::Conf'

apt-get install spamassassin -y


mkdir -p /etc/mail/spamassassin
cd /etc/mail/spamassassin
rm -fr /etc/mail/spamassasssin/local.cf
wget https://api.webcp.io/downloads/3.0.0/setup/local.cf

systemctl enable spamassassin
service spamassassin start


