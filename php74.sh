#!/bin/bash


##################
#
# PHP
#
##################

apt-get install php7.4-fpm php7.4-mysql php7.4-xml php7.4-gd php7.4-zip php7.4-curl php7.4-mbstring  php7.4-xml php7.4-soap php7.4-imap php7.4-opcache -y

apt-get install php7.4-intl php7.4-cli php7.4-common php7.4-curl php7.4-fpm php7.4-gd php7.4-imap php7.4-intl php7.4-json php7.4-mbstring php7.4-mcrypt php7.4-mysql php7.4-opcache php7.4-readline php7.4-soap php7.4-xml php7.4-zip -y


pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime Mail_mimeDecode

	apt-get install php7.4-opcache






echo "[PHP]" > /etc/php/7.4/fpm/php.ini 
echo "engine = On" >> /etc/php/7.4/fpm/php.ini 
echo "expose_php = Off" >> /etc/php/7.4/fpm/php.ini 
echo "zend_extension = /etc/php/7.4/ioncube_loader_lin_7.4.so" >> /etc/php/7.4/fpm/php.ini 
echo "max_execution_time = 5" >> /etc/php/7.4/fpm/php.ini 
echo "memory_limit = -1" >> /etc/php/7.4/fpm/php.ini 
echo "error_reporting = E_ALL & ~E_DEPRECATED" >> /etc/php/7.4/fpm/php.ini 
echo "display_errors = Off" >> /etc/php/7.4/fpm/php.ini 
echo "display_startup_errors = Off" >> /etc/php/7.4/fpm/php.ini 
echo "html_errors = Off" >> /etc/php/7.4/fpm/php.ini 
echo "default_socket_timeout = 5" >> /etc/php/7.4/fpm/php.ini 
echo "" >> /etc/php/7.4/fpm/php.ini 
echo "file_uploads = On" >> /etc/php/7.4/fpm/php.ini 
echo "upload_tmp_dir = /tmp/php" >> /etc/php/7.4/fpm/php.ini 
echo "upload_max_filesize = 50M" >> /etc/php/7.4/fpm/php.ini 
echo "post_max_size = 50M" >> /etc/php/7.4/fpm/php.ini 
echo "max_file_uploads = 20" >> /etc/php/7.4/fpm/php.ini 
echo "" >> /etc/php/7.4/fpm/php.ini 
echo "date.timezone = 'Africa/Johannesburg'" >> /etc/php/7.4/fpm/php.ini 
echo "" >> /etc/php/7.4/fpm/php.ini 
echo "cgi.fix_pathinfo = 0" >> /etc/php/7.4/fpm/php.ini 
echo "" >> /etc/php/7.4/fpm/php.ini 
echo "[opcache]" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.enable=1" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.revalidate_freq=5" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.validate_timestamps=1" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.max_accelerated_files=7963" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.memory_consumption=192" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.interned_strings_buffer=16" >> /etc/php/7.4/fpm/php.ini 
echo "opcache.fast_shutdown=1" >> /etc/php/7.4/fpm/php.ini 




echo "[PHP]" > /etc/php/7.4/cli/php.ini
echo "engine = On" >> /etc/php/7.4/cli/php.ini
echo "zend_extension = /etc/php/7.4/ioncube_loader_lin_7.4.so" >> /etc/php/7.4/cli/php.ini
echo "zlib.output_compression = Off" >> /etc/php/7.4/cli/php.ini
echo "implicit_flush = Off" >> /etc/php/7.4/cli/php.ini
echo "unserialize_callback_func =" >> /etc/php/7.4/cli/php.ini
echo "serialize_precision = 17" >> /etc/php/7.4/cli/php.ini
echo "disable_functions =" >> /etc/php/7.4/cli/php.ini
echo "disable_classes =" >> /etc/php/7.4/cli/php.ini
echo "zend.enable_gc = On" >> /etc/php/7.4/cli/php.ini
echo "expose_php = On" >> /etc/php/7.4/cli/php.ini
echo "max_execution_time = 30" >> /etc/php/7.4/cli/php.ini
echo "max_input_time = 60" >> /etc/php/7.4/cli/php.ini
echo "memory_limit = -1" >> /etc/php/7.4/cli/php.ini
echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /etc/php/7.4/cli/php.ini
echo "display_errors = Off" >> /etc/php/7.4/cli/php.ini
echo "display_startup_errors = Off" >> /etc/php/7.4/cli/php.ini
echo "log_errors = On" >> /etc/php/7.4/cli/php.ini
echo "log_errors_max_len = 1024" >> /etc/php/7.4/cli/php.ini
echo "ignore_repeated_errors = Off" >> /etc/php/7.4/cli/php.ini
echo "ignore_repeated_source = Off" >> /etc/php/7.4/cli/php.ini
echo "report_memleaks = On" >> /etc/php/7.4/cli/php.ini
echo "track_errors = Off" >> /etc/php/7.4/cli/php.ini
echo "html_errors = On" >> /etc/php/7.4/cli/php.ini
echo "variables_order = \"GPCS\"" >> /etc/php/7.4/cli/php.ini
echo "request_order = \"GP\"" >> /etc/php/7.4/cli/php.ini
echo "register_argc_argv = Off" >> /etc/php/7.4/cli/php.ini
echo "auto_globals_jit = On" >> /etc/php/7.4/cli/php.ini
echo "post_max_size = 8M" >> /etc/php/7.4/cli/php.ini
echo "auto_prepend_file =" >> /etc/php/7.4/cli/php.ini
echo "auto_append_file =" >> /etc/php/7.4/cli/php.ini
echo "default_mimetype = \"text/html\"" >> /etc/php/7.4/cli/php.ini
echo "default_charset = \"UTF-8\"" >> /etc/php/7.4/cli/php.ini
echo "doc_root =" >> /etc/php/7.4/cli/php.ini
echo "user_dir =" >> /etc/php/7.4/cli/php.ini
echo "enable_dl = Off" >> /etc/php/7.4/cli/php.ini
echo "file_uploads = On" >> /etc/php/7.4/cli/php.ini
echo "upload_max_filesize = 2M" >> /etc/php/7.4/cli/php.ini
echo "max_file_uploads = 20" >> /etc/php/7.4/cli/php.ini
echo "allow_url_fopen = On" >> /etc/php/7.4/cli/php.ini
echo "allow_url_include = Off" >> /etc/php/7.4/cli/php.ini
echo "default_socket_timeout = 60" >> /etc/php/7.4/cli/php.ini
echo "[CLI Server]" >> /etc/php/7.4/cli/php.ini
echo "cli_server.color = On" >> /etc/php/7.4/cli/php.ini
echo "[Pdo_mysql]" >> /etc/php/7.4/cli/php.ini
echo "pdo_mysql.cache_size = 2000" >> /etc/php/7.4/cli/php.ini
echo "pdo_mysql.default_socket=" >> /etc/php/7.4/cli/php.ini
echo "[Session]" >> /etc/php/7.4/cli/php.ini
echo "session.save_handler = files" >> /etc/php/7.4/cli/php.ini
echo "session.use_strict_mode = 0" >> /etc/php/7.4/cli/php.ini
echo "session.use_cookies = 1" >> /etc/php/7.4/cli/php.ini
echo "session.use_only_cookies = 1" >> /etc/php/7.4/cli/php.ini
echo "session.name = PHPSESSID" >> /etc/php/7.4/cli/php.ini
echo "session.auto_start = 0" >> /etc/php/7.4/cli/php.ini
echo "session.cookie_lifetime = 0" >> /etc/php/7.4/cli/php.ini
echo "session.cookie_path = /" >> /etc/php/7.4/cli/php.ini
echo "session.cookie_domain =" >> /etc/php/7.4/cli/php.ini
echo "session.cookie_httponly =" >> /etc/php/7.4/cli/php.ini
echo "session.serialize_handler = php" >> /etc/php/7.4/cli/php.ini
echo "session.gc_probability = 0" >> /etc/php/7.4/cli/php.ini
echo "session.gc_divisor = 1000" >> /etc/php/7.4/cli/php.ini
echo "session.gc_maxlifetime = 1440" >> /etc/php/7.4/cli/php.ini
echo "session.referer_check =" >> /etc/php/7.4/cli/php.ini
echo "session.cache_limiter = nocache" >> /etc/php/7.4/cli/php.ini
echo "session.cache_expire = 180" >> /etc/php/7.4/cli/php.ini
echo "session.use_trans_sid = 0" >> /etc/php/7.4/cli/php.ini
echo "session.hash_function = 0" >> /etc/php/7.4/cli/php.ini
echo "session.hash_bits_per_character = 5" >> /etc/php/7.4/cli/php.ini
echo "url_rewriter.tags = \"a=href,area=href,frame=src,input=src,form=" >> /etc/php/7.4/cli/php.inifakeentry\"
echo "[Assertion]" >> /etc/php/7.4/cli/php.ini
echo "zend.assertions = -1" >> /etc/php/7.4/cli/php.ini
echo "[Tidy]" >> /etc/php/7.4/cli/php.ini
echo "tidy.clean_output = Off" >> /etc/php/7.4/cli/php.ini
echo "[soap]" >> /etc/php/7.4/cli/php.ini
echo "soap.wsdl_cache_enabled=1" >> /etc/php/7.4/cli/php.ini
echo "soap.wsdl_cache_dir=\"/tmp\"" >> /etc/php/7.4/cli/php.ini
echo "soap.wsdl_cache_ttl=86400" >> /etc/php/7.4/cli/php.ini
echo "soap.wsdl_cache_limit = 5" >> /etc/php/7.4/cli/php.ini







cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip --no-check-certificate
unzip ioncube_loaders_lin_x86-64.zip
cp /tmp/ioncube/ioncube_loader_lin_7.4.so /etc/php/7.4

service php7.4-fpm restart

