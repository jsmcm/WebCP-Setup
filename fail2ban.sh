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


/tmp/fail2ban_conf.sh

systemctl enable fail2ban
service fail2ban start

