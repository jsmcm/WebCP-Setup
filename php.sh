#!/bin/bash


##################
#
# PHP
#
##################

apt-get install php-fpm php-mysql php-xml php-gd php-zip php-curl php-mbstring  php-xml php-soap php-imap php-opcache -y
apt-get install php-pear -y

apt-get install php-auth php-intl php-mail-mime php-mail-mimedecode php-net-smtp php-net-socket php-cli php-common php-curl php-fpm php-gd php-imap php-intl php-json php-mbstring php-mcrypt php-mysql php-opcache php-readline php-soap php-xml php-zip -y


pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime Mail_mimeDecode

phpVersion=`php -v | grep PHP\ 7 | cut -d ' ' -f 2 | cut -d '.' -f1,2`

if [ "$phpVersion" = "7.1" ]
then
	apt-get install php7.1-mcrypt php7.1-opcache php7.1-auth

elif [ "$phpVersion" = "7.2" ]
then
	apt-get install php7.2-mcrypt php7.2-opcache php7.2-auth
elif [ "$phpVersion" = "7.3" ]
then
	apt-get install php7.3-mcrypt php7.3-opcache php7.3-auth
fi


echo "[PHP]" > /etc/php/$phpVersion/fpm/php.ini 
echo "engine = On" >> /etc/php/$phpVersion/fpm/php.ini 
echo "expose_php = Off" >> /etc/php/$phpVersion/fpm/php.ini 
echo "zend_extension = /etc/php/$phpVersion/ioncube_loader_lin_$phpVersion.so" >> /etc/php/$phpVersion/fpm/php.ini 
echo "max_execution_time = 5" >> /etc/php/$phpVersion/fpm/php.ini 
echo "memory_limit = -1" >> /etc/php/$phpVersion/fpm/php.ini 
echo "error_reporting = E_ALL & ~E_DEPRECATED" >> /etc/php/$phpVersion/fpm/php.ini 
echo "display_errors = Off" >> /etc/php/$phpVersion/fpm/php.ini 
echo "display_startup_errors = Off" >> /etc/php/$phpVersion/fpm/php.ini 
echo "html_errors = Off" >> /etc/php/$phpVersion/fpm/php.ini 
echo "default_socket_timeout = 5" >> /etc/php/$phpVersion/fpm/php.ini 
echo "" >> /etc/php/$phpVersion/fpm/php.ini 
echo "file_uploads = On" >> /etc/php/$phpVersion/fpm/php.ini 
echo "upload_tmp_dir = /tmp/php" >> /etc/php/$phpVersion/fpm/php.ini 
echo "upload_max_filesize = 50M" >> /etc/php/$phpVersion/fpm/php.ini 
echo "post_max_size = 50M" >> /etc/php/$phpVersion/fpm/php.ini 
echo "max_file_uploads = 20" >> /etc/php/$phpVersion/fpm/php.ini 
echo "" >> /etc/php/$phpVersion/fpm/php.ini 
echo "date.timezone = 'Africa/Johannesburg'" >> /etc/php/$phpVersion/fpm/php.ini 
echo "" >> /etc/php/$phpVersion/fpm/php.ini 
echo "cgi.fix_pathinfo = 0" >> /etc/php/$phpVersion/fpm/php.ini 
echo "" >> /etc/php/$phpVersion/fpm/php.ini 
echo "[opcache]" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.enable=1" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.revalidate_freq=5" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.validate_timestamps=1" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.max_accelerated_files=7963" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.memory_consumption=192" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.interned_strings_buffer=16" >> /etc/php/$phpVersion/fpm/php.ini 
echo "opcache.fast_shutdown=1" >> /etc/php/$phpVersion/fpm/php.ini 




echo "[PHP]" > /etc/php/$phpVersion/cli/php.ini
echo "engine = On" >> /etc/php/$phpVersion/cli/php.ini
echo "zend_extension = /etc/php/$phpVersion/ioncube_loader_lin_$phpVersion.so" >> /etc/php/$phpVersion/cli/php.ini
echo "zlib.output_compression = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "implicit_flush = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "unserialize_callback_func =" >> /etc/php/$phpVersion/cli/php.ini
echo "serialize_precision = 17" >> /etc/php/$phpVersion/cli/php.ini
echo "disable_functions =" >> /etc/php/$phpVersion/cli/php.ini
echo "disable_classes =" >> /etc/php/$phpVersion/cli/php.ini
echo "zend.enable_gc = On" >> /etc/php/$phpVersion/cli/php.ini
echo "expose_php = On" >> /etc/php/$phpVersion/cli/php.ini
echo "max_execution_time = 30" >> /etc/php/$phpVersion/cli/php.ini
echo "max_input_time = 60" >> /etc/php/$phpVersion/cli/php.ini
echo "memory_limit = -1" >> /etc/php/$phpVersion/cli/php.ini
echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /etc/php/$phpVersion/cli/php.ini
echo "display_errors = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "display_startup_errors = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "log_errors = On" >> /etc/php/$phpVersion/cli/php.ini
echo "log_errors_max_len = 1024" >> /etc/php/$phpVersion/cli/php.ini
echo "ignore_repeated_errors = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "ignore_repeated_source = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "report_memleaks = On" >> /etc/php/$phpVersion/cli/php.ini
echo "track_errors = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "html_errors = On" >> /etc/php/$phpVersion/cli/php.ini
echo "variables_order = \"GPCS\"" >> /etc/php/$phpVersion/cli/php.ini
echo "request_order = \"GP\"" >> /etc/php/$phpVersion/cli/php.ini
echo "register_argc_argv = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "auto_globals_jit = On" >> /etc/php/$phpVersion/cli/php.ini
echo "post_max_size = 8M" >> /etc/php/$phpVersion/cli/php.ini
echo "auto_prepend_file =" >> /etc/php/$phpVersion/cli/php.ini
echo "auto_append_file =" >> /etc/php/$phpVersion/cli/php.ini
echo "default_mimetype = \"text/html\"" >> /etc/php/$phpVersion/cli/php.ini
echo "default_charset = \"UTF-8\"" >> /etc/php/$phpVersion/cli/php.ini
echo "doc_root =" >> /etc/php/$phpVersion/cli/php.ini
echo "user_dir =" >> /etc/php/$phpVersion/cli/php.ini
echo "enable_dl = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "file_uploads = On" >> /etc/php/$phpVersion/cli/php.ini
echo "upload_max_filesize = 2M" >> /etc/php/$phpVersion/cli/php.ini
echo "max_file_uploads = 20" >> /etc/php/$phpVersion/cli/php.ini
echo "allow_url_fopen = On" >> /etc/php/$phpVersion/cli/php.ini
echo "allow_url_include = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "default_socket_timeout = 60" >> /etc/php/$phpVersion/cli/php.ini
echo "[CLI Server]" >> /etc/php/$phpVersion/cli/php.ini
echo "cli_server.color = On" >> /etc/php/$phpVersion/cli/php.ini
echo "[Pdo_mysql]" >> /etc/php/$phpVersion/cli/php.ini
echo "pdo_mysql.cache_size = 2000" >> /etc/php/$phpVersion/cli/php.ini
echo "pdo_mysql.default_socket=" >> /etc/php/$phpVersion/cli/php.ini
echo "[Session]" >> /etc/php/$phpVersion/cli/php.ini
echo "session.save_handler = files" >> /etc/php/$phpVersion/cli/php.ini
echo "session.use_strict_mode = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.use_cookies = 1" >> /etc/php/$phpVersion/cli/php.ini
echo "session.use_only_cookies = 1" >> /etc/php/$phpVersion/cli/php.ini
echo "session.name = PHPSESSID" >> /etc/php/$phpVersion/cli/php.ini
echo "session.auto_start = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cookie_lifetime = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cookie_path = /" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cookie_domain =" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cookie_httponly =" >> /etc/php/$phpVersion/cli/php.ini
echo "session.serialize_handler = php" >> /etc/php/$phpVersion/cli/php.ini
echo "session.gc_probability = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.gc_divisor = 1000" >> /etc/php/$phpVersion/cli/php.ini
echo "session.gc_maxlifetime = 1440" >> /etc/php/$phpVersion/cli/php.ini
echo "session.referer_check =" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cache_limiter = nocache" >> /etc/php/$phpVersion/cli/php.ini
echo "session.cache_expire = 180" >> /etc/php/$phpVersion/cli/php.ini
echo "session.use_trans_sid = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.hash_function = 0" >> /etc/php/$phpVersion/cli/php.ini
echo "session.hash_bits_per_character = 5" >> /etc/php/$phpVersion/cli/php.ini
echo "url_rewriter.tags = \"a=href,area=href,frame=src,input=src,form=" >> /etc/php/$phpVersion/cli/php.inifakeentry\"
echo "[Assertion]" >> /etc/php/$phpVersion/cli/php.ini
echo "zend.assertions = -1" >> /etc/php/$phpVersion/cli/php.ini
echo "[Tidy]" >> /etc/php/$phpVersion/cli/php.ini
echo "tidy.clean_output = Off" >> /etc/php/$phpVersion/cli/php.ini
echo "[soap]" >> /etc/php/$phpVersion/cli/php.ini
echo "soap.wsdl_cache_enabled=1" >> /etc/php/$phpVersion/cli/php.ini
echo "soap.wsdl_cache_dir=\"/tmp\"" >> /etc/php/$phpVersion/cli/php.ini
echo "soap.wsdl_cache_ttl=86400" >> /etc/php/$phpVersion/cli/php.ini
echo "soap.wsdl_cache_limit = 5" >> /etc/php/$phpVersion/cli/php.ini



cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip --no-check-certificate
unzip ioncube_loaders_lin_x86-64.zip
cp /tmp/ioncube/ioncube_loader_lin_$phpVersion.so /etc/php/$phpVersion

service php$phpVersion-fpm restart




