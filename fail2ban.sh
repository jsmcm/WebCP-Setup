#!/bin/bash

apt-get install python -y
apt-get install fail2ban -y

#https://gist.github.com/Nihisil/29fd2971c9dd109ae245
#https://askubuntu.com/questions/487740/how-do-you-view-all-of-the-banned-ips-for-ubuntu-12-04-via-the-command-line
#https://ubuntu101.co.za/security/fail2ban/fail2ban-persistent-bans-ubuntu/
#https://wireflare.com/blog/permanently-ban-repeat-offenders-with-fail2ban/
#http://www.the-lazy-dev.com/en/fail2ban-client-show-banned-ips/

#fail2ban-client status | grep "Jail list:" | sed "s/ //g" | awk '{split($2,a,",");for(i in a) system("fail2ban-client status " a[i])}' | grep "Status\|IP list"
#fail2ban-client set <JAIL-NAME> unbanip <IP-ADDRESS>
#fail2ban-client set <JAIL-NAME> banip <IP-ADDRESS>


echo "# Fail2Ban filter for spamhause bans in webcp" > /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "#" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "#" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "failregex =" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "" >> /etc/fail2ban/filter.d/webcp-spamhause.conf
echo "# Author: John McMurray <john@softsmart.co.za>" >> /etc/fail2ban/filter.d/webcp-spamhause.conf


echo "# Fail2Ban filter for manual bans in webcp" > /etc/fail2ban/filter.d/webcp-manual.conf
echo "#" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "#" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "failregex =" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "" >> /etc/fail2ban/filter.d/webcp-manual.conf
echo "# Author: John McMurray <john@softsmart.co.za>" >> /etc/fail2ban/filter.d/webcp-manual.conf


echo "# Fail2Ban configuration file" > /etc/fail2ban/action.d/webcp.conf
echo "#" >> /etc/fail2ban/action.d/webcp.conf
echo "# Author: John McMurray <john@softsmart.co.za>" >> /etc/fail2ban/action.d/webcp.conf
echo "#" >> /etc/fail2ban/action.d/webcp.conf
echo "#" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "[Definition]" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "actionstart = touch /var/run/fail2ban/fail2ban.webcp" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "actionstop = rm -f /var/run/fail2ban/fail2ban.webcp" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "actioncheck =" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "actionban = /usr/webcp/fail2ban/ban_notice.sh <name> <bantime> <ip>" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "actionunban = /usr/webcp/fail2ban/unban_notice.sh <name> <ip>" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "[Init]" >> /etc/fail2ban/action.d/webcp.conf
echo "" >> /etc/fail2ban/action.d/webcp.conf
echo "init = WebCP notifications" >> /etc/fail2ban/action.d/webcp.conf


echo "# Fail2Ban filter Dovecot authentication and pop3/imap server" > /etc/fail2ban/filter.d/dovecot.conf
echo "#" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "[INCLUDES]" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "before = common.conf" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "_daemon = (auth|dovecot(-auth)?|auth-worker)" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf

echo "failregex = ^%(__prefix_line)s(%(__pam_auth)s(\\(dovecot:auth\\))?:)?\\s+authentication failure; logname=\\S* uid=\\S* euid=\\S* tty=dovecot ruser=\\S* rhost=<HOST>(\\s+user=\\S*)?\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf
echo "	^%(__prefix_line)s(pop3|imap)-login: (Info: )?(Aborted login|Disconnected)(: Inactivity)? \\(((auth failed, \\d+ attempts)( in \\d+ secs)?|tried to use (disabled|disallowed) \\S+ auth)\\):( user=<\\S*>,)?( method=\\S+,)? rip=<HOST>(, lip=(\\d{1,3}\\.){3}\\d{1,3})?(, TLS( handshaking(: SSL_accept\\(\\) failed: error:[\\dA-F]+:SSL routines:[TLS\\d]+_GET_CLIENT_HELLO:unknown protocol)?)?(: Disconnected)?)?(, session=<\\S+>)?\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf
echo "	^%(__prefix_line)s(Info|dovecot: auth\\(default\\)|auth-worker\\(\\d+\\)): pam\\(\\S+,<HOST>\\): pam_authenticate\\(\\) failed: (User not known to the underlying authentication module: \\d+ Time\\(s\\)|Authentication failure \\(password mismatch\\?\\))\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf
echo "	^%(__prefix_line)s(auth|auth-worker\\(\\d+\\)): (pam|passwd-file)\\(\\S+,<HOST>\\): unknown user\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf
echo "	^%(__prefix_line)sauth: Info: passwd-file\\(\\S+,<HOST>,<\\S+>\\): Password mismatch\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf
echo "	^%(__prefix_line)sauth: Error: passwd-file\\(\\S+,<HOST>,<\\S+>\\): stat\\(\\S+\\) failed: No such file or directory\\s*\$" >> /etc/fail2ban/filter.d/dovecot.conf

echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "[Init]" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "journalmatch = _SYSTEMD_UNIT=dovecot.service" >> /etc/fail2ban/filter.d/dovecot.conf
echo "" >> /etc/fail2ban/filter.d/dovecot.conf
echo "# DEV Notes:" >> /etc/fail2ban/filter.d/dovecot.conf
echo "# * the first regex is essentially a copy of pam-generic.conf" >> /etc/fail2ban/filter.d/dovecot.conf
echo "# * Probably doesn't do dovecot sql/ldap backends properly" >> /etc/fail2ban/filter.d/dovecot.conf
echo "# * Removed the 'no auth attempts' log lines from the matches because produces" >> /etc/fail2ban/filter.d/dovecot.conf
echo "#    lots of false positives on misconfigured MTAs making regexp unusable" >> /etc/fail2ban/filter.d/dovecot.conf
echo "#" >> /etc/fail2ban/filter.d/dovecot.conf
echo "# Author: Martin Waschbuesch" >> /etc/fail2ban/filter.d/dovecot.conf
echo "#         Daniel Black (rewrote with begin and end anchors)" >> /etc/fail2ban/filter.d/dovecot.conf





echo "# Fail2Ban RAINLOOP configuration file" > /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Author: eRVee Moskovic" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# \$Revision\$" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Option: failregex" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Notes.: regex to match the password failures messages in the logfile. The" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#          host must be matched by a group named \"host\". The tag \"<HOST>\" can" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#          be used for standard IP/hostname matching." >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Values: TEXT" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "failregex = Auth failed: ip=<HOST> user=.* host=.* port=.*" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Option:  ignoreregex" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Notes.:  regex to ignore. If this regex matches, the line is ignored." >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Values:  TEXT" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf




echo "# Fail2Ban PHPMYADMIN configuration file" > /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Author: John McMurrray (john@softsmart.co.za)" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# \$Revision\$" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Option: failregex" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Notes.: regex to match the password failures messages in the logfile. The" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#          host must be matched by a group named \"host\". The tag \"<HOST>\" can" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#          be used for standard IP/hostname matching." >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Values: TEXT" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "failregex = user denied: .* from <HOST>" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Option:  ignoreregex" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Notes.:  regex to ignore. If this regex matches, the line is ignored." >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "# Values:  TEXT" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "#" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/phpmyadmin.conf
echo "" >> /etc/fail2ban/filter.d/phpmyadmin.conf



echo "# Fail2Ban filter for WordPress hard failures" > /etc/fail2ban/filter.d/wordpress-hard.conf
echo "#" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "[INCLUDES]" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "before = common.conf" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "_daemon = (?:wordpress|wp)" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "failregex = ^%(__prefix_line)sAuthentication attempt for unknown user .* from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sBlocked user enumeration attempt from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sBlocked authentication attempt for .* from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sPingback error .* generated from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sSpam comment \\d+ from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sXML-RPC authentication attempt for unknown user .* from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "	^%(__prefix_line)sXML-RPC multicall authentication failure from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# DEV Notes:" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# Requires the 'WP fail2ban' plugin:" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# https://wordpress.org/plugins/wp-fail2ban/" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "#" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# Author: Charles Lecklider" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf


echo "# Fail2Ban filter for exim" > /etc/fail2ban/filter.d/exim.conf
echo "#" >> /etc/fail2ban/filter.d/exim.conf
echo "# This includes the rejection messages of exim. For spam and filter" >> /etc/fail2ban/filter.d/exim.conf
echo "# related bans use the exim-spam.conf" >> /etc/fail2ban/filter.d/exim.conf
echo "#" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "[INCLUDES]" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "# Read common prefixes. If any customizations available -- read them from" >> /etc/fail2ban/filter.d/exim.conf
echo "# exim-common.local" >> /etc/fail2ban/filter.d/exim.conf
echo "before = exim-common.conf" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "[Definition]" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "failregex = ^%(pid)s %(host_info)ssender verify fail for <\\S+>: (?:Unknown user|Unrouteable address|all relevant MX records point to non-existent hosts)\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
echo "	^%(pid)s \\w+ authenticator failed for (\\S+ )?\\(\\S+\\) \\[<HOST>\\](:\\d+)?( I=\\[\\S+\\](:\\d+)?)?: 535 Incorrect authentication data( \\(set_id=.*\\)|: \\d+ Time\\(s\\))?\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
echo "	^%(pid)s %(host_info)sF=(<>|[^@]+@\\S+) rejected RCPT [^@]+@\\S+: (relay not permitted|Sender verify failed|Unknown user)\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
echo "	^%(pid)s SMTP protocol synchronization error \\([^)]*\\): rejected (connection from|\"\\S+\") %(host_info)s(next )?input=\".*\"\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
echo "	^%(pid)s SMTP call from \\S+ \\[<HOST>\\](:\\d+)? (I=\\[\\S+\\](:\\d+)? )?dropped: too many nonmail commands \\(last was \"\\S+\"\\)\\s*\$" >> /etc/fail2ban/filter.d/exim.conf

echo "	^%(pid)s SMTP protocol error in \"(?:AUTH LOGIN|auth login)\" %(host_info)sAUTH command used when not advertised\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
echo "	^%(pid)s \\w+ authenticator failed for (\\S+ )?\\(\\S+\\) \\[<HOST>\\](:\\d+)?( I=\\[\\S+\\](:\\d+)?)?: 435 Unable to authenticate at present: failed to open (\\S+) for linear search. No such file or directory\\s*\$" >> /etc/fail2ban/filter.d/exim.conf



echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/exim.conf
echo "" >> /etc/fail2ban/filter.d/exim.conf
echo "# DEV Notes:" >> /etc/fail2ban/filter.d/exim.conf
echo "# The %(host_info) defination contains a <HOST> match" >> /etc/fail2ban/filter.d/exim.conf
echo "#" >> /etc/fail2ban/filter.d/exim.conf
echo "# SMTP protocol synchronization error \\([^)]*\\)  <- This needs to be non-greedy" >> /etc/fail2ban/filter.d/exim.conf
echo "# to void capture beyond \")\" to avoid a DoS Injection vulnerabilty as input= is" >> /etc/fail2ban/filter.d/exim.conf
echo "# user injectable data." >> /etc/fail2ban/filter.d/exim.conf
echo "#" >> /etc/fail2ban/filter.d/exim.conf
echo "# Author: Cyril Jaquier" >> /etc/fail2ban/filter.d/exim.conf
echo "#         Daniel Black (rewrote with strong regexs)" >> /etc/fail2ban/filter.d/exim.conf
	     echo "" >> /etc/fail2ban/filter.d/exim.conf
	     echo "" >> /etc/fail2ban/filter.d/exim.conf







echo "" > /etc/fail2ban/jail.local
echo "[DEFAULT]" >> /etc/fail2ban/jail.local
echo "ignoreip = 127.0.0.1/8" >> /etc/fail2ban/jail.local
echo "ignorecommand =" >> /etc/fail2ban/jail.local
echo "bantime  = 600" >> /etc/fail2ban/jail.local
echo "findtime  = 600" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "backend = auto" >> /etc/fail2ban/jail.local
echo "usedns = warn" >> /etc/fail2ban/jail.local
echo "logencoding = auto" >> /etc/fail2ban/jail.local
echo "enabled = false" >> /etc/fail2ban/jail.local
echo "filter = %(__name__)s" >> /etc/fail2ban/jail.local
echo "destemail = root@localhost" >> /etc/fail2ban/jail.local
echo "sender = root@localhost" >> /etc/fail2ban/jail.local
echo "mta = sendmail" >> /etc/fail2ban/jail.local
echo "protocol = tcp" >> /etc/fail2ban/jail.local
echo "chain = INPUT" >> /etc/fail2ban/jail.local
echo "port = 0:65535" >> /etc/fail2ban/jail.local
echo "banaction = iptables-multiport" >> /etc/fail2ban/jail.local
echo "action_ = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "action_mw = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "            %(mta)s-whois[name=%(__name__)s, dest=\"%(destemail)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "action_mwl = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "             %(mta)s-whois-lines[name=%(__name__)s, dest=\"%(destemail)s\", logpath=%(logpath)s, chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "action_xarf = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "             xarf-login-attack[service=%(__name__)s, sender=\"%(sender)s\", logpath=%(logpath)s, port=\"%(port)s\"]" >> /etc/fail2ban/jail.local
echo "action_cf_mwl = cloudflare[cfuser=\"%(cfemail)s\", cftoken=\"%(cfapikey)s\"]" >> /etc/fail2ban/jail.local
echo "                %(mta)s-whois-lines[name=%(__name__)s, dest=\"%(destemail)s\", logpath=%(logpath)s, chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local
echo "action_blocklist_de  = blocklist_de[email=\"%(sender)s\", service=%(filter)s, apikey=\"%(blocklist_de_apikey)s\"]" >> /etc/fail2ban/jail.local
echo "action_badips = badips.py[category=\"%(name)s\", banaction=\"%(banaction)s\"]" >> /etc/fail2ban/jail.local
echo "action = %(action_)s" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[webcp-spamhause]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port    = 0:65535" >> /etc/fail2ban/jail.local
echo "bantime = 604800" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[webcp-manual]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port    = \"0:65535\"" >> /etc/fail2ban/jail.local
echo "bantime = 30" >> /etc/fail2ban/jail.local
echo "action = webcp[name=webcp-manual, bantime=30]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=webcp-manual, port=\"0:65535\", protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[sshd]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port    = 7533" >> /etc/fail2ban/jail.local
echo "logpath = %(sshd_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=sshd, bantime=600]" >> /etc/fail2ban/jail.local
echo "         iptables-multiport[name=sshd, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[sshd-ddos]" >> /etc/fail2ban/jail.local
echo "port    = 7533" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "logpath = %(sshd_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=sshd-ddos, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[nginx-http-auth]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port    = http,https" >> /etc/fail2ban/jail.local
echo "logpath = %(nginx_error_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=nginx-http-auth, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[nginx-botsearch]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port     = http,https" >> /etc/fail2ban/jail.local
echo "logpath  = %(nginx_error_log)s" >> /etc/fail2ban/jail.local
echo "maxretry = 2" >> /etc/fail2ban/jail.local
echo "action = webcp[name=nginx-botsearch, bantime=600]" >> /etc/fail2ban/jail.local
echo "[php-url-fopen]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port    = http,https" >> /etc/fail2ban/jail.local
echo "logpath = %(nginx_access_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=php-url-fopen, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[drupal-auth]" >> /etc/fail2ban/jail.local
echo "enabled = false" >> /etc/fail2ban/jail.local
echo "port     = http,https" >> /etc/fail2ban/jail.local
echo "logpath  = %(syslog_daemon)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=drupal-auth, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[wordpress-hard]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "filter = wordpress-hard" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "port = http,https" >> /etc/fail2ban/jail.local
echo "action = webcp[name=wordpress-hard, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[rainloop]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "filter = rainloop" >> /etc/fail2ban/jail.local
echo "port = 2086,2087" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "logpath = /var/www/html/rainloop/data/_data_/_default_/logs/fail2ban/auth.log" >> /etc/fail2ban/jail.local
echo "findtime = 14400" >> /etc/fail2ban/jail.local
echo "action = webcp[name=rainloop, bantime=600]" >> /etc/fail2ban/jail.local
echo "         iptables-multiport[name=rainloop, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[phpmyadmin]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "filter = phpmyadmin" >> /etc/fail2ban/jail.local
echo "port = 2095,2096" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/phpmyadmin.log" >> /etc/fail2ban/jail.local
echo "action = webcp[name=phpmyadmin, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[monit]" >> /etc/fail2ban/jail.local
echo "filter   = monit" >> /etc/fail2ban/jail.local
echo "port = 2812" >> /etc/fail2ban/jail.local
echo "logpath  = /var/log/monit" >> /etc/fail2ban/jail.local
echo "action = webcp[name=monit, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[pure-ftpd]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port     = ftp,ftp-data,ftps,ftps-data" >> /etc/fail2ban/jail.local
echo "logpath  = %(pureftpd_log)s" >> /etc/fail2ban/jail.local
echo "maxretry = 6" >> /etc/fail2ban/jail.local
echo "action = webcp[name=pure-ftpd, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[dovecot]" >> /etc/fail2ban/jail.local
echo "port    = pop3,pop3s,imap,imaps,submission,465,sieve" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/dovecot/main.log" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "action = webcp[name=dovecot, bantime=600]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=webcp-dovecot, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "[sieve]" >> /etc/fail2ban/jail.local
echo "port   = smtp,465,submission" >> /etc/fail2ban/jail.local
echo "logpath = %(dovecot_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=sieve, bantime=600]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=sieve, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local


echo "[exim]" >> /etc/fail2ban/jail.local
echo "findtime  = 600" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "port   = smtp,465,submission" >> /etc/fail2ban/jail.local
echo "logpath = %(exim_main_log)s" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "action = webcp[name=exim, bantime=600]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=exim, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[exim-spam]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port   = smtp,465,submission" >> /etc/fail2ban/jail.local
echo "logpath = %(exim_main_log)s" >> /etc/fail2ban/jail.local
echo "action = webcp[name=exim-spam, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[named-refused]" >> /etc/fail2ban/jail.local
echo "port     = domain,953" >> /etc/fail2ban/jail.local
echo "logpath  = /var/log/named/security.log" >> /etc/fail2ban/jail.local
echo "action = webcp[name=named-refused, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[mysqld-auth]" >> /etc/fail2ban/jail.local
echo "port     = 3306" >> /etc/fail2ban/jail.local
echo "logpath  = /var/log/mysql/mysqld.log" >> /etc/fail2ban/jail.local
echo "maxretry = 5" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "action = webcp[name=mysql-auth, bantime=600]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=mysql-auth, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local


echo "[recidive]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "logpath  = /var/log/fail2ban.log" >> /etc/fail2ban/jail.local
echo "banaction = iptables-allports" >> /etc/fail2ban/jail.local
echo "bantime  = 604800  ; 1 week" >> /etc/fail2ban/jail.local
echo "findtime = 86400   ; 1 day" >> /etc/fail2ban/jail.local
echo "maxretry = 5" >> /etc/fail2ban/jail.local
echo "action = webcp[name=recidive, bantime=604800]" >> /etc/fail2ban/jail.local
echo "		iptables-multiport[name=recidive, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[pam-generic]" >> /etc/fail2ban/jail.local
echo "banaction = iptables-allports" >> /etc/fail2ban/jail.local
echo "logpath  = %(syslog_authpriv)s" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "action = webcp[name=pam-generic, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[xinetd-fail]" >> /etc/fail2ban/jail.local
echo "banaction = iptables-multiport-log" >> /etc/fail2ban/jail.local
echo "logpath   = %(syslog_daemon)s" >> /etc/fail2ban/jail.local
echo "maxretry  = 2" >> /etc/fail2ban/jail.local
echo "action = webcp[name=xinetd-fail, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[nagios]" >> /etc/fail2ban/jail.local
echo "enabled  = false" >> /etc/fail2ban/jail.local
echo "logpath  = %(syslog_daemon)s     ; nrpe.cfg may define a different log_facility" >> /etc/fail2ban/jail.local
echo "maxretry = 1" >> /etc/fail2ban/jail.local
echo "action = webcp[name=nagios, bantime=600]" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local


systemctl enable fail2ban
service fail2ban start

