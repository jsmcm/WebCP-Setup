#!/bin/bash


PASSWORD=$1

if [ "$PASSWORD" == "" ]
then
        echo "ERROR: Please supply the Rainloop admin password!!!"
        exit
fi

mkdir -p /var/www/html/rainloop/
cd /var/www/html/rainloop

curl -sL https://repository.rainloop.net/installer.php | php

mkdir -p /var/www/html/rainloop/data/_data_/_default_/configs 
mkdir -p /var/www/html/rainloop/data/_data_/_default_/domains
mkdir -p /var/www/html/rainloop/data/_data_/_default_/logs/fail2ban
touch /var/www/html/rainloop/data/_data_/_default_/logs/fail2ban/auth.log

date1=`date +%N | md5sum  | awk '{print $1}'`
date2=`date +%N | md5sum  | awk '{print $1}'`
date3=`date +%N | md5sum  | awk '{print $1}'`

salt="<?php //$date1$date2$date3"

if [ ! -f /var/www/html/rainloop/data/SALT.php ]
then
	echo -n $salt >> /var/www/html/rainloop/data/SALT.php
else
	salt=`cat /var/www/html/rainloop/data/SALT.php`
fi

appSalt=`echo -n ${salt}_default_${salt} | md5sum | awk '{print $1}'`
md5Password=`echo -n $appSalt$PASSWORD$appSalt | md5sum | awk '{print $1}'`


echo "; RainLoop Webmail configuration file" > /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Please don't add custom parameters here, those will be overwritten" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[webmail]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Text displayed as page title" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "title = \"WebCP.pw Webmail\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Text displayed on startup" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "loading_description = \"WebCP.pw Webmail\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "favicon_url = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Theme used by default" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "theme = \"Default\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Allow theme selection on settings screen" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_themes = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_user_background = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Language used by default" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "language = \"en\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Admin Panel interface language" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "language_admin = \"en\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Allow language selection on settings screen" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_languages_on_settings = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_additional_accounts = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_additional_identities = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";  Number of messages displayed on page by default" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "messages_per_page = 20" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; File size limit (MB) for file upload on compose screen" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; 0 for unlimited." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "attachment_size_limit = 10" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[interface]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "show_attachment_thumbnail = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_native_scrollbars = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "new_move_to_folder_button = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[branding]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_logo = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_background = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_desc = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_css = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_powered = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "user_css = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "user_logo = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "user_logo_title = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "user_logo_message = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "user_iframe_message = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "welcome_page_url = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "welcome_page_display = \"none\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[contacts]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enable contacts" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_sync = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sync_interval = 20" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "type = \"sqlite\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "pdo_dsn = \"mysql:host=127.0.0.1;port=3306;dbname=rainloop\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "pdo_user = \"root\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "pdo_password = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "suggestions_limit = 30" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[security]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enable CSRF protection (http://en.wikipedia.org/wiki/Cross-site_request_forgery)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "csrf_protection = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "custom_server_signature = \"RainLoop\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "x_frame_options_header = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "openpgp = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Login and password for web admin panel" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "admin_login = \"webcp\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "admin_password = \"$md5Password\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Access settings" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_admin_panel = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_two_factor_auth = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "force_two_factor_auth = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "hide_x_mailer_header = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "admin_panel_host = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "admin_panel_key = \"admin\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "content_security_policy = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "core_install_access_domain = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[ssl]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Require verification of SSL certificate used." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "verify_certificate = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Allow self-signed certificates. Requires verify_certificate." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_self_signed = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Location of Certificate Authority file on local filesystem (/etc/ssl/certs/ca-certificates.crt)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "cafile = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; capath must be a correctly hashed certificate directory. (/etc/ssl/certs/)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "capath = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[capa]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "folders = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "composer = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "contacts = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "settings = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "quota = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "help = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "reload = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "search = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "search_adv = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "filters = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "x-templates = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "dangerous_actions = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "message_actions = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "messagelist_actions = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "attachments_actions = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[login]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "default_domain = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Allow language selection on webmail login screen" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_languages_on_login = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "determine_user_language = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "determine_user_domain = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "welcome_page = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "hide_submit_button = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "forgot_password_link_url = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "registration_link_url = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_lowercase = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; This option allows webmail to remember the logged in user" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; once they closed the browser window." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Values:" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   \"DefaultOff\" - can be used, disabled by default;" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   \"DefaultOn\"  - can be used, enabled by default;" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   \"Unused\"     - cannot be used" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sign_me_auto = \"DefaultOff\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[plugins]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enable plugin support" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; List of enabled plugins" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enabled_list = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[defaults]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Editor mode used by default (Plain, Html, HtmlForced or PlainForced)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "view_editor_type = \"Html\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; layout: 0 - no preview, 1 - side preview, 2 - bottom preview" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "view_layout = 1" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "view_use_checkboxes = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "autologout = 30" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "show_images = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "contacts_autosave = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "mail_use_threads = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_draft_autosave = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "mail_reply_same_folder = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[logs]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enable logging" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Logs entire request only if error occured (php requred)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "write_on_error_only = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Logs entire request only if php error occured" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "write_on_php_error_only = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Logs entire request only if request timeout (in seconds) occured." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "write_on_timeout_only = 0" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Required for development purposes only." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Disabling this option is not recommended." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "hide_passwords = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "time_offset = \"0\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "session_filter = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Log filename." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; For security reasons, some characters are removed from filename." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Allows for pattern-based folder creation (see examples below)." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Patterns:" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {date:Y-m-d}  - Replaced by pattern-based date" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";                   Detailed info: http://www.php.net/manual/en/function.date.php" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {user:email}  - Replaced by user's email address" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";                   If user is not logged in, value is set to \"unknown\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {user:login}  - Replaced by user's login (the user part of an email)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";                   If user is not logged in, value is set to \"unknown\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {user:domain} - Replaced by user's domain name (the domain part of an email)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";                   If user is not logged in, value is set to \"unknown\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {user:uid}    - Replaced by user's UID regardless of account currently used" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {user:ip}" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {request:ip}  - Replaced by user's IP address" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Others:" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {imap:login} {imap:host} {imap:port}" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   {smtp:login} {smtp:host} {smtp:port}" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Examples:" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   filename = \"log-{date:Y-m-d}.txt\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   filename = \"{date:Y-m-d}/{user:domain}/{user:email}_{user:uid}.log\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo ";   filename = \"{user:email}-{date:Y-m-d}.txt\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "filename = \"log-{date:Y-m-d}.txt\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enable auth logging in a separate file (for fail2ban)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "auth_logging = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "auth_logging_filename = \"fail2ban/auth.log\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "auth_logging_format = \"[{date:Y-m-d H:i:s}] Auth failed: ip={request:ip} user={imap:login} host={imap:host} port={imap:port}\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[debug]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Special option required for development purposes" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[social]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Google" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_enable_auth = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_enable_auth_fast = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_enable_drive = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_enable_preview = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_client_id = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_client_secret = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "google_api_key = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Facebook" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fb_enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fb_app_id = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fb_app_secret = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Twitter" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "twitter_enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "twitter_consumer_key = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "twitter_consumer_secret = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Dropbox" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "dropbox_enable = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "dropbox_api_key = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[cache]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; The section controls caching of the entire application." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Enables caching in the system" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "enable = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Additional caching key. If changed, cache is purged" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "index = \"v1\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Can be: files, APC, memcache, redis (beta)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_driver = \"files\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Additional caching key. If changed, fast cache is purged" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_index = \"v1\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Browser-level cache. If enabled, caching is maintainted without using files" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "http = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Browser-level cache time (seconds, Expires header)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "http_expires = 3600" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Caching message UIDs when searching and sorting (threading)" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "server_uids = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[labs]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; Experimental settings. Handle with care." >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "; " >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_mobile_version = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "ignore_folders_subscription = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "check_new_password_strength = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "update_channel = \"stable\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_gravatar = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_prefetch = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_smart_html_links = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "cache_system_data = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "date_from_headers = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "autocreate_system_folders = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_message_append = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "disable_iconv_if_mbstring_supported = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "login_fault_delay = 1" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "log_ajax_response_write_limit = 300" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_html_editor_source_button = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_html_editor_biti_buttons = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_ctrl_enter_on_compose = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "try_to_detect_hidden_images = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "hide_dangerous_actions = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_app_debug_js = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_mobile_version_for_tablets = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_app_debug_css = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_sort = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_force_selection = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_list_subscribe = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_thread = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_move = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_imap_expunge_all_on_delete = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_forwarded_flag = \"\$Forwarded\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_read_receipt_flag = \"\$ReadReceipt\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_body_text_limit = 555000" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_message_list_fast_simple_search = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_message_list_count_limit_trigger = 0" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_message_list_date_filter = 0" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_message_list_permanent_filter = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_message_all_headers = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_large_thread_limit = 50" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_folder_list_limit = 200" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_show_login_alert = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_use_auth_plain = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_use_auth_cram_md5 = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "smtp_show_server_errors = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "smtp_use_auth_plain = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "smtp_use_auth_cram_md5 = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sieve_allow_raw_script = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sieve_utf8_folder_name = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sieve_auth_plain_initial = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sieve_allow_fileinto_inbox = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "imap_timeout = 300" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "smtp_timeout = 60" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "sieve_timeout = 10" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "domain_list_limit = 99" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "mail_func_clear_headers = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "mail_func_additional_parameters = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "favicon_status = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "folders_spec_limit = 50" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "owncloud_save_folder = \"Attachments\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "owncloud_suggestions = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "curl_proxy = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "curl_proxy_auth = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "in_iframe = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "force_https = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "custom_login_link = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "custom_logout_link = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_external_login = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_external_sso = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "external_sso_key = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "http_client_ip_check_proxy = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_memcache_host = \"127.0.0.1\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_memcache_port = 11211" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_redis_host = \"127.0.0.1\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "fast_cache_redis_port = 6379" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "use_local_proxy_for_external_images = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "detect_image_exif_orientation = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "cookie_default_path = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "cookie_default_secure = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "check_new_messages = On" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "replace_env_in_configuration = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "startup_url = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "strict_html_parser = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "allow_cmd = Off" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "dev_email = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "dev_password = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "[version]" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "current = \"1.12.0\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini
echo "saved = \"Sat, 02 Jun 2018 01:15:46 +0000\"" >> /var/www/html/rainloop/data/_data_/_default_/configs/application.ini




if [ -f /var/www/html/rainloop/data/_data_/_default_/domains/gmail.com.ini ]
then
	rm -fr /var/www/html/rainloop/data/_data_/_default_/domains/gmail.com.in
fi


if [ -f /var/www/html/rainloop/data/_data_/_default_/domains/outlook.com.ini ]
then
	rm -fr /var/www/html/rainloop/data/_data_/_default_/domains/outlook.com.in
fi


if [ -f /var/www/html/rainloop/data/_data_/_default_/domains/qq.com.ini ]
then
	rm -fr /var/www/html/rainloop/data/_data_/_default_/domains/qq.com.in
fi


if [ -f /var/www/html/rainloop/data/_data_/_default_/domains/yahoo.com.ini ]
then
	rm -fr /var/www/html/rainloop/data/_data_/_default_/domains/yahoo.com.in
fi

echo "imap_host = \"localhost\"" > /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "imap_port = 993" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "imap_secure = \"SSL\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "imap_short_login = Off" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "sieve_use = Off" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "sieve_allow_raw = Off" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "sieve_host = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "sieve_port = 4190" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "sieve_secure = \"None\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_host = \"localhost\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_port = 465" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_secure = \"SSL\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_short_login = Off" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_auth = On" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "smtp_php_mail = Off" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 
echo "white_list = \"\"" >> /var/www/html/rainloop/data/_data_/_default_/domains/default.ini 





cd /var/www/html/
chown www-data.www-data rainloop -R


echo "# Fail2Ban configuration file" > /etc/fail2ban/filter.d/rainloop.conf
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
echo "failregex = : Auth failed: ip=<HOST> user=.* host=.* port=.*" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf
echo "" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Option:  ignoreregex" >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Notes.:  regex to ignore. If this regex matches, the line is ignored." >> /etc/fail2ban/filter.d/rainloop.conf
echo "# Values:  TEXT" >> /etc/fail2ban/filter.d/rainloop.conf
echo "#" >> /etc/fail2ban/filter.d/rainloop.conf
echo "ignoreregex =" >> /etc/fail2ban/filter.d/rainloop.conf





