#!/bin/bash

perl -MCPAN -e 'install Mail::SpamAssassin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin'
perl -MCPAN -e 'install Mail::SpamAssassin::Plugin::Shortcircuit'
perl -MCPAN -e 'install Mail::SpamAssassin::Conf'

apt-get install spamassassin -y

systemctl enable spamassassin
service spamassassin start









