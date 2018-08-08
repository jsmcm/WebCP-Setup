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
/usr/bin/wget http://webcp.pw/api/downloads/aliases



echo "# primary_hostname =" > /etc/exim4/exim4.conf
echo "disable_ipv6" >> /etc/exim4/exim4.conf
echo "UNZIP = /usr/bin/unzip" >> /etc/exim4/exim4.conf
echo "UNRAR = /usr/bin/unrar" >> /etc/exim4/exim4.conf
echo "keep_environment = PATH" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "domainlist local_domains = @ : localhost : dsearch;/var/www/html/mail/domains" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "domainlist relay_to_domains = " >> /etc/exim4/exim4.conf
echo "hostlist   relay_from_hosts = 127.0.0.1 : localhost" >> /etc/exim4/exim4.conf
echo "log_selector = +all" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "addresslist sender_whitelist =  wildlsearch;/var/www/html/mail/whitelist" >> /etc/exim4/exim4.conf
echo "hostlist  sender_ip_blacklist = net-iplsearch;/var/www/html/mail/blacklist" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_smtp_dkim = acl_check_dkim" >> /etc/exim4/exim4.conf
echo "acl_smtp_mail = acl_check_mail" >> /etc/exim4/exim4.conf
echo "acl_smtp_rcpt = acl_check_rcpt" >> /etc/exim4/exim4.conf
echo "acl_smtp_data = acl_check_data" >> /etc/exim4/exim4.conf
echo "acl_smtp_mime = acl_check_mime" >> /etc/exim4/exim4.conf
echo "acl_smtp_connect = acl_check_connect" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "av_scanner = clamd:/var/run/clamav/clamd.ctl" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "spamd_address = 127.0.0.1 783" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "tls_advertise_hosts = *" >> /etc/exim4/exim4.conf
echo "#tls_require_ciphers = ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:-LOW:-SSLv2:-EXP" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "tls_certificate = /etc/exim4/certificate.crt" >> /etc/exim4/exim4.conf
echo "tls_privatekey = /etc/exim4/privkey.key" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "daemon_smtp_ports = 25 : 465 : 587" >> /etc/exim4/exim4.conf
echo "tls_on_connect_ports = 465" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "never_users = root" >> /etc/exim4/exim4.conf
echo "host_lookup = *" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "auth_advertise_hosts = *" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "rfc1413_hosts = *" >> /etc/exim4/exim4.conf
echo "rfc1413_query_timeout = 0s" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "ignore_bounce_errors_after = 2d" >> /etc/exim4/exim4.conf
echo "timeout_frozen_after = 7d" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "message_size_limit = 50M" >> /etc/exim4/exim4.conf
echo "system_filter = /etc/exim4/system_filter" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "smtp_banner = \$smtp_active_hostname ESMTP Exim \$version_number \$tod_full" >> /etc/exim4/exim4.conf
echo "dns_again_means_nonexist = !+local_domains : !+relay_to_domains" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "helo_try_verify_hosts = *" >> /etc/exim4/exim4.conf
echo "smtp_accept_max = 0" >> /etc/exim4/exim4.conf
echo "smtp_load_reserve = 10" >> /etc/exim4/exim4.conf
echo "pipelining_advertise_hosts = :" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin acl" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_dkim:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn" >> /etc/exim4/exim4.conf
echo "		log_message = \"DKIM: \$dkim_verify_status for domain \${sender_address}\"" >> /etc/exim4/exim4.conf
echo "	        add_header = X-WebCP-DKIM-Status: \$dkim_verify_status" >> /etc/exim4/exim4.conf
echo "		dkim_status 	= none:invalid:fail" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_mail:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny " >> /etc/exim4/exim4.conf
echo "		condition = \${if eq{\$sender_helo_name}{} {1}}" >> /etc/exim4/exim4.conf
echo "      		message = How rude! No helo? I feel so used... dirty almost" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn " >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if eq{\$sender_host_name}{} {1}}" >> /etc/exim4/exim4.conf
echo "       		log_message = Host \$sender_host_address lacks reverse DNS.. Reverse DNS lookup failed for \$sender_host_address (\${if eq{\$host_lookup_failed}{1}{failed}{deferred}})" >> /etc/exim4/exim4.conf
echo "       		add_header = X-WebCP-RDNS-Failed: Reverse DNS lookup failed for \$sender_host_address (\${if eq{\$host_lookup_failed}{1}{failed}{deferred}})" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "  	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_connect:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_rcpt:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn" >> /etc/exim4/exim4.conf
echo "		authenticated = *" >> /etc/exim4/exim4.conf
echo "                set acl_m_local_part = \$sender_address_local_part" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_receiver_domain = \$domain" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_sender_address = \$sender_address" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_global_rate_limit = \${if exists{/var/www/html/mail/ratelimit} {\${readfile{/var/www/html/mail/ratelimit}{}}}{300}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_rate_limit = \${if exists{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/ratelimit} {\${readfile{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/ratelimit}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "		set acl_m_use_rate_limit = \${if eq {\$acl_m_domain_rate_limit}{0}{\$acl_m_global_rate_limit}{\$acl_m_domain_rate_limit}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_catch_all_email = \${if exists{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/catchall} {\${readfile{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/catchall}{}}}{}}" >> /etc/exim4/exim4.conf
echo "		set acl_m_catch_all_domain = \${if !eq {\$acl_m_catch_all_email}{}{\$sender_address_domain}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "		set acl_m_is_forward = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/forward/\$local_part}{1}{0}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_global_max_recipients = \${if exists{/var/www/html/mail/maxrecipients} {\${readfile{/var/www/html/mail/maxrecipients}{}}}{50}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_max_recipients = \${if exists{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/maxrecipients} {\${readfile{/var/www/html/mail/domains/\${lc:\$sender_address_domain}/maxrecipients}{}}}{0}}			" >> /etc/exim4/exim4.conf
echo "                set acl_m_use_max_recipients = \${if eq {\$acl_m_domain_max_recipients}{0}{\$acl_m_global_max_recipients}{\$acl_m_domain_max_recipients}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn" >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "                set acl_m_local_part = \$local_part" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_receiver_domain = \$domain" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_sender_address = \$sender_address" >> /etc/exim4/exim4.conf
echo "	" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_user = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/username} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/username}{}}}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_global_rate_limit = \${if exists{/var/www/html/mail/ratelimit} {\${readfile{/var/www/html/mail/ratelimit}{}}}{300}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_rate_limit = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/ratelimit} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/ratelimit}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "		set acl_m_use_rate_limit = \${if eq {\$acl_m_domain_rate_limit}{0}{\$acl_m_global_rate_limit}{\$acl_m_domain_rate_limit}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_catch_all_email = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/catchall} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/catchall}{}}}{}}" >> /etc/exim4/exim4.conf
echo "		set acl_m_catch_all_domain = \${if !eq {\$acl_m_catch_all_email}{}{\$domain}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "		set acl_m_is_forward = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/forward/\$local_part}{1}{0}}" >> /etc/exim4/exim4.conf
echo "		set acl_m_mailbox_exists = \${if exists{/home/\${acl_m_domain_user}/mail/\${lc:\$domain}/\$local_part}{1}{0}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_global_deny_spam_score = \${if exists{/var/www/html/mail/denyspamscore} {\${readfile{/var/www/html/mail/denyspamscore}{}}}{65}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_deny_spam_score = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/denyspamscore} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/denyspamscore}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_deny_spam_score = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/denyspamscore} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/denyspamscore}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_use_deny_spam_score = \${if eq {\$acl_m_email_deny_spam_score}{0}{\$acl_m_domain_deny_spam_score}{\$acl_m_email_deny_spam_score}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_use_deny_spam_score = \${if eq {\$acl_m_use_deny_spam_score}{0}{\$acl_m_global_deny_spam_score}{\$acl_m_use_deny_spam_score}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_global_warn_spam_score = \${if exists{/var/www/html/mail/warnspamscore} {\${readfile{/var/www/html/mail/warnspamscore}{}}}{35}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_domain_warn_spam_score = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/warnspamscore} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/warnspamscore}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_warn_spam_score = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/warnspamscore} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/warnspamscore}{}}}{0}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_use_warn_spam_score = \${if eq {\$acl_m_email_warn_spam_score}{0}{\$acl_m_domain_warn_spam_score}{\$acl_m_email_warn_spam_score}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_use_warn_spam_score = \${if eq {\$acl_m_use_warn_spam_score}{0}{\$acl_m_global_warn_spam_score}{\$acl_m_use_warn_spam_score}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_warn_spam_subject = \${if exists{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/warnspamsubject} {\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/\${lc:\$local_part}/warnspamsubject}{}}}{*** spam *** }}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_exists = \${if !eq {\$acl_m_catch_all_email}{}{1}{0}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_exists = \${if eq {\$acl_m_email_exists}{0}{\${acl_m_is_forward}}{1}}" >> /etc/exim4/exim4.conf
echo "                set acl_m_email_exists = \${if eq {\$acl_m_email_exists}{0}{\${acl_m_mailbox_exists}}{1}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept  hosts = :" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny" >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if eq {\$acl_m_email_exists}{0}{1}{} }" >> /etc/exim4/exim4.conf
echo "		message = That mailbox does not exist1!" >> /etc/exim4/exim4.conf
echo "		log_message = Mailbox does not exist1 - \$local_part@\$domain" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept " >> /etc/exim4/exim4.conf
echo "		senders = : +sender_whitelist" >> /etc/exim4/exim4.conf
echo "        	control = submission" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	drop " >> /etc/exim4/exim4.conf
echo "		hosts = : +sender_ip_blacklist" >> /etc/exim4/exim4.conf
echo "		message = ip in blacklist" >> /etc/exim4/exim4.conf
echo "		log_message = ip in blacklist" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny" >> /etc/exim4/exim4.conf
echo "		ratelimit = \$acl_m_use_rate_limit / 1h / per_rcpt / \$sender_address_domain" >> /etc/exim4/exim4.conf
echo "		log_message = \"ratelimit emails = \$sender_rate, \$sender_address, \$sender_address_domain\"" >> /etc/exim4/exim4.conf
echo "		message = \"Sorry, you have sent too many emails as per our policy. Please wait an hour, then try again\"" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny    " >> /etc/exim4/exim4.conf
echo "		message       = Restricted characters in address" >> /etc/exim4/exim4.conf
echo "          	domains       = +local_domains" >> /etc/exim4/exim4.conf
echo "          	local_parts   = ^[.] : ^.*[@%!/|]" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "	deny    " >> /etc/exim4/exim4.conf
echo "		message       = Restricted characters in address" >> /etc/exim4/exim4.conf
echo "        	domains       = !+local_domains" >> /etc/exim4/exim4.conf
echo "         	local_parts   = ^[./|] : ^.*[@%!] : ^.*/\\\\.\\\\./" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept  " >> /etc/exim4/exim4.conf
echo "		local_parts   = postmaster" >> /etc/exim4/exim4.conf
echo "          	domains       = +local_domains" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	" >> /etc/exim4/exim4.conf
echo "	require " >> /etc/exim4/exim4.conf
echo "		message = sender verify failed???" >> /etc/exim4/exim4.conf
echo "		verify        = sender" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept  " >> /etc/exim4/exim4.conf
echo "		hosts         = : +relay_from_hosts" >> /etc/exim4/exim4.conf
echo "           	control       = submission" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept  " >> /etc/exim4/exim4.conf
echo "		authenticated = *" >> /etc/exim4/exim4.conf
echo "          	control       = submission/sender_retain/domain=" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	require " >> /etc/exim4/exim4.conf
echo "		message = relay not permitted" >> /etc/exim4/exim4.conf
echo "		log_message = relay not permitted" >> /etc/exim4/exim4.conf
echo "          	domains = +local_domains : +relay_to_domains" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo " 	require " >> /etc/exim4/exim4.conf
echo "		message = Recipient no verified???" >> /etc/exim4/exim4.conf
echo "		log_message = Recipient no verified???" >> /etc/exim4/exim4.conf
echo "		verify = recipient" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "   	deny" >> /etc/exim4/exim4.conf
echo "    		 message = [SPF] \$sender_host_address is not allowed to send mail from \\" >> /etc/exim4/exim4.conf
echo "               		\${if def:sender_address_domain {\$sender_address_domain}{\$sender_helo_name}}.  \\" >> /etc/exim4/exim4.conf
echo "               		Please see \\" >> /etc/exim4/exim4.conf
echo "               		http://www.openspf.org/Why?scope=\${if def:sender_address_domain \\" >> /etc/exim4/exim4.conf
echo "            		{mfrom}{helo}};identity=\${if def:sender_address_domain \\" >> /etc/exim4/exim4.conf
echo "               		{\$sender_address}{\$sender_helo_name}};ip=\$sender_host_address" >> /etc/exim4/exim4.conf
echo "     		log_message = SPF check failed." >> /etc/exim4/exim4.conf
echo "     		condition = \${run{/usr/bin/spfquery.mail-spf-perl --ip \\" >> /etc/exim4/exim4.conf
echo "                    	\${quote:\$sender_host_address} --identity \\" >> /etc/exim4/exim4.conf
echo "                    	\${if def:sender_address_domain \\" >> /etc/exim4/exim4.conf
echo "                        {--scope mfrom  --identity \${quote:\$sender_address}}\\" >> /etc/exim4/exim4.conf
echo "                        {--scope helo --identity \${quote:\$sender_helo_name}}}}\\" >> /etc/exim4/exim4.conf
echo "                    	{no}{\${if eq {\$runrc}{1}{yes}{no}}}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "   	defer" >> /etc/exim4/exim4.conf
echo "     		message = Temporary DNS error while checking SPF record.  Try again later." >> /etc/exim4/exim4.conf
echo "     		condition = \${if eq {\$runrc}{5}{yes}{no}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "   	warn" >> /etc/exim4/exim4.conf
echo "     		condition = \${if <={\$runrc}{6}{yes}{no}}" >> /etc/exim4/exim4.conf
echo "     		add_header = Received-SPF: \${if eq {\$runrc}{0}{pass}\\" >> /etc/exim4/exim4.conf
echo "                                 {\${if eq {\$runrc}{2}{softfail}\\" >> /etc/exim4/exim4.conf
echo "                                  {\${if eq {\$runrc}{3}{neutral}\\" >> /etc/exim4/exim4.conf
echo "                                   {\${if eq {\$runrc}{4}{permerror}\\" >> /etc/exim4/exim4.conf
echo "                                    {\${if eq {\$runrc}{6}{none}{error}}}}}}}}}\\" >> /etc/exim4/exim4.conf
echo "                                } client-ip=\$sender_host_address; \\" >> /etc/exim4/exim4.conf
echo "                                 \${if def:sender_address_domain \\" >> /etc/exim4/exim4.conf
echo "                                    {envelope-from=\${sender_address}; }{}}\\" >> /etc/exim4/exim4.conf
echo "                                 helo=\$sender_helo_name" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	warn" >> /etc/exim4/exim4.conf
echo "    		log_message = Unexpected error in SPF check." >> /etc/exim4/exim4.conf
echo "     		condition = \${if >{\$runrc}{6}{yes}{no}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	drop" >> /etc/exim4/exim4.conf
echo "   		message      = Legitimate bounces are never sent to more than one recipient." >> /etc/exim4/exim4.conf
echo "    		senders      = : postmaster@*" >> /etc/exim4/exim4.conf
echo "   		condition    = \$recipients_count" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message     = relay not permitted" >> /etc/exim4/exim4.conf
echo "    		!domains    = +local_domains : +relay_to_domains" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message     = unknown user" >> /etc/exim4/exim4.conf
echo "   	 	!verify     = recipient/callout=20s,defer_ok" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message     = Message was delivered by ratware" >> /etc/exim4/exim4.conf
echo "    		log_message = remote host used IP address in HELO/EHLO greeting" >> /etc/exim4/exim4.conf
echo "    		condition   = \${if isip {\$sender_helo_name}{true}{false}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message     = Message was delivered by ratware" >> /etc/exim4/exim4.conf
echo "    		log_message = remote host used our name in HELO/EHLO greeting." >> /etc/exim4/exim4.conf
echo "   	 	condition   = \${if match_domain{\$sender_helo_name}\\" >> /etc/exim4/exim4.conf
echo "                      	{\$primary_hostname:+local_domains:+relay_to_domains}\\" >> /etc/exim4/exim4.conf
echo "                	{true}{false}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message     = Message was delivered by ratware" >> /etc/exim4/exim4.conf
echo "    		log_message = remote host did not present HELO/EHLO greeting." >> /etc/exim4/exim4.conf
echo "    		condition   = \${if def:sender_helo_name {false}{true}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	warn" >> /etc/exim4/exim4.conf
echo "   		 message     = X-HELO-Warning: Remote host \$sender_host_address \\" >> /etc/exim4/exim4.conf
echo "                  	\${if def:sender_host_name {(\$sender_host_name) }}\\" >> /etc/exim4/exim4.conf
echo "                  	incorrectly presented itself as \$sender_helo_name" >> /etc/exim4/exim4.conf
echo "    		log_message = remote host presented unverifiable HELO/EHLO greeting." >> /etc/exim4/exim4.conf
echo "    		!verify     = helo" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	" >> /etc/exim4/exim4.conf
echo "	deny " >> /etc/exim4/exim4.conf
echo "		message = JunkMail rejected - \$sender_fullhost is in an RBL, see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "		dnslists = dnsbl.njabl.org" >> /etc/exim4/exim4.conf
echo "		log_message = DNSBL - dnsbl.njabl.org - see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn" >> /etc/exim4/exim4.conf
echo "		message = \$sender_fullhost in SORBS, see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "		dnslists = dnsbl.sorbs.net" >> /etc/exim4/exim4.conf
echo "        	add_header = X-WebCP-Sorbs: YES" >> /etc/exim4/exim4.conf
echo "		log_message = DNSBL - dnsbl.sorbs.net - see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny " >> /etc/exim4/exim4.conf
echo "		message = JunkMail rejected - \$sender_fullhost is in an RBL, see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "		dnslists = cbl.abuseat.org" >> /etc/exim4/exim4.conf
echo "		log_message = DNSBL - cbl.abuseat.org - see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny " >> /etc/exim4/exim4.conf
echo "		message = JunkMail rejected - \$sender_fullhost is in an RBL, see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "		dnslists = bl.spamcop.net" >> /etc/exim4/exim4.conf
echo "		log_message = DNSBL - bl.spamcop.net - see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny " >> /etc/exim4/exim4.conf
echo "		message = JunkMail rejected - \$sender_fullhost is in an RBL, see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "		dnslists = zen.spamhaus.org" >> /etc/exim4/exim4.conf
echo "		log_message = DNSBL - zen.spamhaus.org - see \$dnslist_text" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	delay = 1s" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_data:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept " >> /etc/exim4/exim4.conf
echo "		senders = : +sender_whitelist" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "    		message = Message headers fail syntax check" >> /etc/exim4/exim4.conf
echo "    		!verify = header_syntax" >> /etc/exim4/exim4.conf
echo "    " >> /etc/exim4/exim4.conf
echo "    " >> /etc/exim4/exim4.conf
echo " 	deny" >> /etc/exim4/exim4.conf
echo "  		message = No verifiable sender address in message headers" >> /etc/exim4/exim4.conf
echo "  		!verify = header_sender" >> /etc/exim4/exim4.conf
echo "    " >> /etc/exim4/exim4.conf
echo "    " >> /etc/exim4/exim4.conf
echo "  	deny    " >> /etc/exim4/exim4.conf
echo "		condition  = \${if !def:h_Message-ID: {1}}" >> /etc/exim4/exim4.conf
echo "  		message    = RFC2822 says that all mail SHOULD have a Message-ID header.\\n\\" >> /etc/exim4/exim4.conf
echo "  		Most messages without it are spam, so your mail has been rejected." >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny  " >> /etc/exim4/exim4.conf
echo "		authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if >{\$recipients_count}{\$acl_m_use_max_recipients}}" >> /etc/exim4/exim4.conf
echo "		log_message = RECIPIENT_COUNT: \$recipients_count (\$acl_m_use_max_recipients allowed); Sender Address: \$sender_address" >> /etc/exim4/exim4.conf
echo "		message = Sorry, you are not permitted to send emails with that many recipients. Please try with a smaller number of recipients." >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny  " >> /etc/exim4/exim4.conf
echo "		message = This message contains a virus (\$malware_name)." >> /etc/exim4/exim4.conf
echo "       		malware = *" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "   	accept  " >> /etc/exim4/exim4.conf
echo "		condition  = \${if >={\$message_size}{2048576} {1}}" >> /etc/exim4/exim4.conf
echo "           	add_header = X-Spam-Note: SpamAssassin run bypassed due to message size" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "   	warn    	" >> /etc/exim4/exim4.conf
echo "		spam       = nobody/defer_ok" >> /etc/exim4/exim4.conf
echo "           	add_header = X-Spam-Flag: YES" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo " 	accept  " >> /etc/exim4/exim4.conf
echo "		condition  = \${if !def:spam_score_int {1}}" >> /etc/exim4/exim4.conf
echo "           	add_header = X-Spam-Note: SpamAssassin invocation failed" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo " " >> /etc/exim4/exim4.conf
echo "	warn " >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "  		add_header = X-Spam-Score: \$spam_score (\$spam_bar)\\n\\" >> /etc/exim4/exim4.conf
echo "                        X-Spam-Report: \$spam_report" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn " >> /etc/exim4/exim4.conf
echo "		authenticated = *" >> /etc/exim4/exim4.conf
echo "  		add_header = X-Out-Spam-Score: \$spam_score (\$spam_bar)\\n\\" >> /etc/exim4/exim4.conf
echo "                        X-Out-Spam-Report: \$spam_report" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	warn   " >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if >{\$spam_score_int}{  \$acl_m_use_warn_spam_score  } {1}}" >> /etc/exim4/exim4.conf
echo "		add_header = X-Spam-Possible: YES" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "		!authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if >{\$spam_score_int}{ \$acl_m_use_deny_spam_score } {1}}" >> /etc/exim4/exim4.conf
echo "           	log_message   = Your message to \$acl_m_local_part@\$acl_m_receiver_domain scored \$spam_score_int SpamAssassin point." >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny" >> /etc/exim4/exim4.conf
echo "		authenticated = *" >> /etc/exim4/exim4.conf
echo "		condition = \${if >={\$spam_score_int}{ 129 } {1}}" >> /etc/exim4/exim4.conf
echo "          	log_message   = [OUTBOUND SA] - Message from \$acl_m_sender_address to \$acl_m_local_part@\$acl_m_receiver_domain scored \$spam_score_int SpamAssassin point." >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "acl_check_mime:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	deny " >> /etc/exim4/exim4.conf
echo "		message = Blacklisted file extension detected" >> /etc/exim4/exim4.conf
echo "       		condition = \${if match \\" >> /etc/exim4/exim4.conf
echo "                  	{\${lc:\$mime_filename}} \\" >> /etc/exim4/exim4.conf
echo "                        {\\N(\\.pif|\\.bat|\\.scr|\\.lnk|\\.com)\$\\N} \\" >> /etc/exim4/exim4.conf
echo "                     	{1}{0}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	deny " >> /etc/exim4/exim4.conf
echo "		message = Windows-executable attachments forbidden" >> /etc/exim4/exim4.conf
echo "      		condition = \${if def:sender_host_address}" >> /etc/exim4/exim4.conf
echo "      		!authenticated = *" >> /etc/exim4/exim4.conf
echo "     		log_message = forbidden attachment: filename=\$mime_filename, \\" >> /etc/exim4/exim4.conf
echo "                     	content-type=\$mime_content_type, recipients=\$recipients" >> /etc/exim4/exim4.conf
echo "      		condition = \${if or{\\" >> /etc/exim4/exim4.conf
echo "                       	{match{\$mime_content_type}{(?i)executable}}\\" >> /etc/exim4/exim4.conf
echo "                        {match{\$mime_filename}{\\N(?i)\\.(exe|com|vbs|bat|\\" >> /etc/exim4/exim4.conf
echo "  			pif|scr|hta|js|cmd|chm|cpl|jsp|reg|vbe|lnk|dll|sys|btm|dat|msi|prf|vb)\$\\N}}\\" >> /etc/exim4/exim4.conf
echo "                        }}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo " 	deny " >> /etc/exim4/exim4.conf
echo "		set acl_m_att = \${if match{\$mime_filename}{\\N(?i)\\.(zip|rar)\$\\N}{\$1}}" >> /etc/exim4/exim4.conf
echo "      		condition = \${if def:acl_m_att}" >> /etc/exim4/exim4.conf
echo "      		message = A .\$acl_m_att attachment contains a Windows-executable file \\" >> /etc/exim4/exim4.conf
echo "                	- blocked because we are afraid of new viruses \\" >> /etc/exim4/exim4.conf
echo "                	not recognized [yet] by antiviruses." >> /etc/exim4/exim4.conf
echo "  		condition = \${if def:sender_host_address}" >> /etc/exim4/exim4.conf
echo "      		!authenticated = *" >> /etc/exim4/exim4.conf
echo "      		decode = default" >> /etc/exim4/exim4.conf
echo "      		log_message = forbidden binary in attachment: filename=\$mime_filename, \\" >> /etc/exim4/exim4.conf
echo "                    	recipients=\$recipients" >> /etc/exim4/exim4.conf
echo "      		condition = \${if match{\${run{\${if eqi{\$acl_m_att}{zip}\\" >> /etc/exim4/exim4.conf
echo "                    	{UNZIP -l}{UNRAR lt}} \$mime_decoded_filename}}}\\" >> /etc/exim4/exim4.conf
echo "                        {\\N(?i)\\n .+\\.(zip|rar|exe|com|vbs|bat|pif|scr|vb\\" >> /etc/exim4/exim4.conf
echo "          		|js|cmd|chm|cpl|jsp|reg|vbe|lnk|dll|sys|btm|dat|msi|prf|hta)\\n\\N}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "  	accept" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin routers" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "send_via_sendgrid:" >> /etc/exim4/exim4.conf
echo "	driver = manualroute" >> /etc/exim4/exim4.conf
echo "	senders =  \${if exists{/var/www/html/mail/sendgrid/domains} {\${readfile{/var/www/html/mail/sendgrid/domains}{}}}{}}" >> /etc/exim4/exim4.conf
echo "	domains = !+local_domains" >> /etc/exim4/exim4.conf
echo "	transport = sendgrid_smtp" >> /etc/exim4/exim4.conf
echo "	route_list = * smtp.sendgrid.net ;" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "uservacation:" >> /etc/exim4/exim4.conf
echo "  	driver = redirect" >> /etc/exim4/exim4.conf
echo "  	allow_filter" >> /etc/exim4/exim4.conf
echo "  	hide_child_in_errmsg" >> /etc/exim4/exim4.conf
echo "  	ignore_eacces" >> /etc/exim4/exim4.conf
echo "  	ignore_enotdir" >> /etc/exim4/exim4.conf
echo "  	reply_transport = vacation_reply" >> /etc/exim4/exim4.conf
echo "  	no_verify" >> /etc/exim4/exim4.conf
echo "	file = /etc/exim/vacation" >> /etc/exim4/exim4.conf
echo "	user = Debian-exim" >> /etc/exim4/exim4.conf
echo "	group = Debian-exim" >> /etc/exim4/exim4.conf
echo "	unseen" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "dnslookup:" >> /etc/exim4/exim4.conf
echo "  	driver = dnslookup" >> /etc/exim4/exim4.conf
echo "  	domains = ! +local_domains" >> /etc/exim4/exim4.conf
echo "  	transport = remote_smtp" >> /etc/exim4/exim4.conf
echo "  	ignore_target_hosts = 0.0.0.0 : 127.0.0.0/8" >> /etc/exim4/exim4.conf
echo "  	no_more" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "system_aliases:" >> /etc/exim4/exim4.conf
echo "  	driver = redirect" >> /etc/exim4/exim4.conf
echo "  	allow_fail" >> /etc/exim4/exim4.conf
echo "  	allow_defer" >> /etc/exim4/exim4.conf
echo "  	data = \${lookup{\$local_part}lsearch{/etc/aliases}}" >> /etc/exim4/exim4.conf
echo "  	file_transport = address_file" >> /etc/exim4/exim4.conf
echo "  	pipe_transport = address_pipe" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "userforward:" >> /etc/exim4/exim4.conf
echo "  	driver = redirect" >> /etc/exim4/exim4.conf
echo "  	file = /home/\${readfile{/var/www/html/mail/domains/\${lc:\$domain}/username}{}}/mail/\${domain}/.forward" >> /etc/exim4/exim4.conf
echo "  	allow_filter" >> /etc/exim4/exim4.conf
echo "  	allow_fail" >> /etc/exim4/exim4.conf
echo "  	no_verify" >> /etc/exim4/exim4.conf
echo "  	no_expn" >> /etc/exim4/exim4.conf
echo "  	check_ancestor" >> /etc/exim4/exim4.conf
echo "  	file_transport = address_file" >> /etc/exim4/exim4.conf
echo "  	pipe_transport = address_pipe" >> /etc/exim4/exim4.conf
echo "  	reply_transport = address_reply" >> /etc/exim4/exim4.conf
echo "	user = \${readfile{/var/www/html/mail/domains/\${lc:\$domain}/username}{}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "procmail:" >> /etc/exim4/exim4.conf
echo "  	driver = accept" >> /etc/exim4/exim4.conf
echo "  	check_local_user" >> /etc/exim4/exim4.conf
echo "  	require_files = \${local_part}:+\${home}/.procmailrc:/usr/bin/procmail" >> /etc/exim4/exim4.conf
echo "  	transport = procmail" >> /etc/exim4/exim4.conf
echo "  	no_verify" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "localuser:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	headers_remove = Subject" >> /etc/exim4/exim4.conf
echo "	headers_add = \${if and{ {eq{\$h_X-Spam-Possible:}{YES}} \\" >> /etc/exim4/exim4.conf
echo "                        {!eq{\$acl_m_email_warn_spam_subject} {} }  \\" >> /etc/exim4/exim4.conf
echo "                      } \\" >> /etc/exim4/exim4.conf
echo "                        {Subject: \$acl_m_email_warn_spam_subject \$h_Subject:} \\" >> /etc/exim4/exim4.conf
echo "                        {Subject: \$h_Subject:} \\" >> /etc/exim4/exim4.conf
echo "               }" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	driver = accept" >> /etc/exim4/exim4.conf
echo " 	require_files = \${if eq {\$acl_m_is_forward}{0}{/home/\${readfile{/var/www/html/mail/domains/\${domain}/username}{}}/mail/\${domain}/\${local_part}/}{}}" >> /etc/exim4/exim4.conf
echo " " >> /etc/exim4/exim4.conf
echo "	" >> /etc/exim4/exim4.conf
echo "	transport = dovecot_delivery" >> /etc/exim4/exim4.conf
echo "	condition = \${if eq {\$acl_m_email_exists}{1}{1}{} }" >> /etc/exim4/exim4.conf
echo "  	cannot_route_message = I dont know this Unknown user" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "catchall:" >> /etc/exim4/exim4.conf
echo "  	driver = redirect" >> /etc/exim4/exim4.conf
echo "	domains = \$acl_m_catch_all_domain	" >> /etc/exim4/exim4.conf
echo "	data = \$acl_m_catch_all_email" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "dovecot_router:" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	driver = accept" >> /etc/exim4/exim4.conf
echo " 	require_files = /home/\${readfile{/var/www/html/mail/domains/\${domain}/username}{}}/mail/\${domain}/\${local_part}/" >> /etc/exim4/exim4.conf
echo "	transport = dovecot_delivery" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin transports" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "sendgrid_smtp:" >> /etc/exim4/exim4.conf
echo "  	driver = smtp" >> /etc/exim4/exim4.conf
echo "  	port = 587" >> /etc/exim4/exim4.conf
echo "	hosts = smtp.sendgrid.net" >> /etc/exim4/exim4.conf
echo "  	hosts_require_auth = <; \$host_address" >> /etc/exim4/exim4.conf
echo "  	hosts_require_tls = <; \$host_address" >> /etc/exim4/exim4.conf
echo "  " >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "vacation_reply:" >> /etc/exim4/exim4.conf
echo "  	driver = autoreply" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "remote_smtp:" >> /etc/exim4/exim4.conf
echo "	driver = smtp" >> /etc/exim4/exim4.conf
echo "	dkim_domain = \${lc:\${domain:\$h_from:}}" >> /etc/exim4/exim4.conf
echo "	dkim_private_key = \${if exists{/etc/exim/dkim/\${lc:\${domain:\$h_from:}}}{/etc/exim/dkim.private.key}{0}}" >> /etc/exim4/exim4.conf
echo "	dkim_selector = x" >> /etc/exim4/exim4.conf
echo "	dkim_canon = relaxed" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "remote_msa:" >> /etc/exim4/exim4.conf
echo "  	driver = smtp" >> /etc/exim4/exim4.conf
echo "  	port = 587" >> /etc/exim4/exim4.conf
echo "  	hosts_require_auth = *" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "procmail:" >> /etc/exim4/exim4.conf
echo "  	driver = pipe" >> /etc/exim4/exim4.conf
echo "  	command = \"/usr/bin/procmail -d \$local_part\"" >> /etc/exim4/exim4.conf
echo "  	return_path_add" >> /etc/exim4/exim4.conf
echo "  	delivery_date_add" >> /etc/exim4/exim4.conf
echo "  	envelope_to_add" >> /etc/exim4/exim4.conf
echo "  	user = \$local_part" >> /etc/exim4/exim4.conf
echo "  	initgroups" >> /etc/exim4/exim4.conf
echo "  	return_output" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "dovecot_delivery:" >> /etc/exim4/exim4.conf
echo "	driver = appendfile" >> /etc/exim4/exim4.conf
echo "	maildir_format = true" >> /etc/exim4/exim4.conf
echo "	directory = /home/\${readfile{/var/www/html/mail/domains/\${domain}/username}{}}/mail/\${domain}/\${local_part}/" >> /etc/exim4/exim4.conf
echo "	create_directory = true" >> /etc/exim4/exim4.conf
echo "	directory_mode = 0770" >> /etc/exim4/exim4.conf
echo "	mode_fail_narrower = false" >> /etc/exim4/exim4.conf
echo "	message_prefix =" >> /etc/exim4/exim4.conf
echo "	message_suffix =" >> /etc/exim4/exim4.conf
echo "	delivery_date_add" >> /etc/exim4/exim4.conf
echo "	envelope_to_add" >> /etc/exim4/exim4.conf
echo "	return_path_add" >> /etc/exim4/exim4.conf
echo "	user = \${readfile{/var/www/html/mail/domains/\${domain}/username}{}}" >> /etc/exim4/exim4.conf
echo "	group = \${readfile{/var/www/html/mail/domains/\${domain}/username}{}}" >> /etc/exim4/exim4.conf
echo "	mode = 0660" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "local_delivery:" >> /etc/exim4/exim4.conf
echo "	driver = appendfile" >> /etc/exim4/exim4.conf
echo "  	maildir_format = true" >> /etc/exim4/exim4.conf
echo "	directory = /home/\${readfile{/var/www/html/mail/domains/\${domain}/username}{}}/mail/\${domain}/\${local_part}/" >> /etc/exim4/exim4.conf
echo "  	create_directory = true" >> /etc/exim4/exim4.conf
echo " 	directory_mode = 0770" >> /etc/exim4/exim4.conf
echo "  	delivery_date_add" >> /etc/exim4/exim4.conf
echo "  	envelope_to_add" >> /etc/exim4/exim4.conf
echo "  	return_path_add" >> /etc/exim4/exim4.conf
echo "	user = \${readfile{/var/www/html/mail/domains/\${domain}/username}{}}" >> /etc/exim4/exim4.conf
echo "	group = \${readfile{/var/www/html/mail/domains/\${domain}/username}{}}" >> /etc/exim4/exim4.conf
echo "  	mode = 0660" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "address_pipe:" >> /etc/exim4/exim4.conf
echo "  	driver = pipe" >> /etc/exim4/exim4.conf
echo "  	return_output" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "address_file:" >> /etc/exim4/exim4.conf
echo "  	driver = appendfile" >> /etc/exim4/exim4.conf
echo "  	delivery_date_add" >> /etc/exim4/exim4.conf
echo "  	envelope_to_add" >> /etc/exim4/exim4.conf
echo "  	return_path_add" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "address_reply:" >> /etc/exim4/exim4.conf
echo "  	driver = autoreply" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin retry" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "*                      *           F,2h,15m; G,16h,1h,1.5; F,4d,6h" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin rewrite" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "begin authenticators" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "sendgrid_login:" >> /etc/exim4/exim4.conf
echo "	driver = plaintext" >> /etc/exim4/exim4.conf
echo "	public_name = LOGIN" >> /etc/exim4/exim4.conf
echo "	client_send = : \${if exists{/var/www/html/mail/sendgrid/username} {\${readfile{/var/www/html/mail/sendgrid/username}{}}}{}} : \${if exists{/var/www/html/mail/sendgrid/password} {\${readfile{/var/www/html/mail/sendgrid/password}{}}}{}}" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "auth_plain:" >> /etc/exim4/exim4.conf
echo "	driver = plaintext" >> /etc/exim4/exim4.conf
echo "	public_name = PLAIN" >> /etc/exim4/exim4.conf
echo "	server_condition = \${lookup{\$2}lsearch{/var/www/html/mail/domains/\${domain:\$2}/passwd}\\" >> /etc/exim4/exim4.conf
echo "                     {\${if crypteq{\$3}{\\{md5\\}\$value}{yes}{no}}}{no}}" >> /etc/exim4/exim4.conf
echo "	server_prompts = :" >> /etc/exim4/exim4.conf
echo "	server_set_id = \$2" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "	" >> /etc/exim4/exim4.conf
echo "login:" >> /etc/exim4/exim4.conf
echo "	driver = plaintext" >> /etc/exim4/exim4.conf
echo "	public_name = LOGIN" >> /etc/exim4/exim4.conf
echo "	server_condition = \${lookup{\$1}lsearch{/var/www/html/mail/domains/\${domain:\$1}/passwd}\\" >> /etc/exim4/exim4.conf
echo "                     {\${if crypteq{\$2}{\\{md5\\}\$value}{yes}{no}}}{no}}" >> /etc/exim4/exim4.conf
echo "	server_prompts = Username:: : Password::" >> /etc/exim4/exim4.conf
echo "" >> /etc/exim4/exim4.conf
echo "# End of Exim configuration file" >> /etc/exim4/exim4.conf

