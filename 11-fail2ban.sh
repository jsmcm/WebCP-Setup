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
            echo "^%(__prefix_line)sBlocked user enumeration attempt from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
            echo "^%(__prefix_line)sBlocked authentication attempt for .* from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
            echo "^%(__prefix_line)sPingback error .* generated from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
            echo "^%(__prefix_line)sSpam comment \\d+ from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
            echo "^%(__prefix_line)sXML-RPC authentication attempt for unknown user .* from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
            echo "^%(__prefix_line)sXML-RPC multicall authentication failure from <HOST>\$" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# DEV Notes:" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# Requires the 'WP fail2ban' plugin:" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# https://wordpress.org/plugins/wp-fail2ban/" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "#" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "# Author: Charles Lecklider" >> /etc/fail2ban/filter.d/wordpress-hard.conf
echo "" >> /etc/fail2ban/filter.d/wordpress-hard.conf


echo "# Fail2Ban filter for exim" >> /etc/fail2ban/filter.d/exim.conf
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
             echo "^%(pid)s \\w+ authenticator failed for (\\S+ )?\\(\\S+\\) \\[<HOST>\\](:\\d+)?( I=\\[\\S+\\](:\\d+)?)?: 535 Incorrect authentication data( \\(set_id=.*\\)|: \\d+ Time\\(s\\))?\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
             echo "^%(pid)s %(host_info)sF=(<>|[^@]+@\\S+) rejected RCPT [^@]+@\\S+: (relay not permitted|Sender verify failed|Unknown user)\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
             echo "^%(pid)s SMTP protocol synchronization error \\([^)]*\\): rejected (connection from|\"\\S+\") %(host_info)s(next )?input=\".*\"\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
             echo "^%(pid)s SMTP call from \\S+ \\[<HOST>\\](:\\d+)? (I=\\[\\S+\\](:\\d+)? )?dropped: too many nonmail commands \\(last was \"\\S+\"\\)\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
             echo "^%(pid)s SMTP protocol error in \"AUTH LOGIN\" %(host_info)sAUTH command used when not advertised\\s*\$" >> /etc/fail2ban/filter.d/exim.conf
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







systemctl enable fail2ban
service fail2ban start

