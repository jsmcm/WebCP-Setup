#!/bin/bash


##################
#
# nginx 
#
##################

phpVersion=`php -v | grep PHP\ 7 | cut -d ' ' -f 2 | cut -d '.' -f1,2`

cd /tmp

git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1-stable

mkdir webcp
chown www-data.www-data webcp
chmod 770 webcp

wget http://nginx.org/download/nginx-1.15.8.tar.gz
tar zxf nginx-1.15.8.tar.gz
cd nginx-1.15.8




./configure --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/etc/nginx/modules \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock \
            --user=www-data \
            --group=www-data \
            --build=Ubuntu \
            --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
            --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
            --with-openssl-opt=no-weak-ssl-ciphers \
            --with-openssl-opt=no-ssl3 \
	    --with-threads \
            --with-compat \
            --with-file-aio \
            --with-http_addition_module \
            --with-http_auth_request_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_mp4_module \
            --with-http_random_index_module \
            --with-http_realip_module \
            --with-http_slice_module \
            --with-http_ssl_module \
            --with-http_sub_module \
            --with-http_stub_status_module \
            --with-http_v2_module \
            --with-http_secure_link_module \
            --with-mail \
            --with-mail_ssl_module \
            --with-stream  \
	    --with-stream_realip_module  \
	    --with-stream_ssl_module  \
	    --with-stream_ssl_preread_module \
            --with-debug \
	    --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' \
            --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' \
	    --with-openssl=/tmp/openssl
        

make


make install

mkdir -p /var/lib/nginx 
mkdir -p /var/cache/nginx/client_temp



cd /etc/nginx
mkdir snippets
cd snippets



echo "# regex to split \$uri to \$fastcgi_script_name and \$fastcgi_path" > fastcgi-php.conf
echo "fastcgi_split_path_info ^(.+\.php)(/.+)\$;" >> fastcgi-php.conf
echo "" >> fastcgi-php.conf
echo "# Check that the PHP script exists before passing it" >> fastcgi-php.conf
echo "try_files \$fastcgi_script_name =404;" >> fastcgi-php.conf
echo "" >> fastcgi-php.conf
echo "# Bypass the fact that try_files resets \$fastcgi_path_info" >> fastcgi-php.conf
echo "# see: http://trac.nginx.org/nginx/ticket/321" >> fastcgi-php.conf
echo "set \$path_info \$fastcgi_path_info;" >> fastcgi-php.conf
echo "fastcgi_param PATH_INFO \$path_info;" >> fastcgi-php.conf
echo "" >> fastcgi-php.conf
echo "fastcgi_index index.php;" >> fastcgi-php.conf
echo "include fastcgi.conf;" >> fastcgi-php.conf
echo "" >> fastcgi-php.conf




echo "# Self signed certificates generated by the ssl-cert package" > snakeoil.conf          
echo "# Don't use them in a production server!" >> snakeoil.conf          
echo "" >> snakeoil.conf          
echo "ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;" >> snakeoil.conf          
echo "ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;" >> snakeoil.conf          



echo "#user  nobody;" > /etc/nginx/nginx.conf
echo "worker_processes  10;" >> /etc/nginx/nginx.conf
echo "load_module /etc/nginx/modules/ngx_http_modsecurity_module.so;" >> /etc/nginx/nginx.conf
echo "error_log  /var/log/nginx/error.log warn;" >> /etc/nginx/nginx.conf
echo "#error_log  logs/error.log  notice;" >> /etc/nginx/nginx.conf
echo "#error_log  logs/error.log  info;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "pid        /var/run/nginx.pid;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "events {" >> /etc/nginx/nginx.conf
    echo "worker_connections  1024;" >> /etc/nginx/nginx.conf
echo "}" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "http {" >> /etc/nginx/nginx.conf
    echo "include       mime.types;" >> /etc/nginx/nginx.conf
    echo "default_type  application/octet-stream;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
    echo "log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '" >> /etc/nginx/nginx.conf
                      echo "'\$status \$body_bytes_sent \"\$http_referer\" '" >> /etc/nginx/nginx.conf
                      echo "'\"\$http_user_agent\" \"\$http_x_forwarded_for\"';" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
            echo "access_log  /var/log/nginx/access.log  main;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
    echo "sendfile        on;" >> /etc/nginx/nginx.conf
    echo "#tcp_nopush     on;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "client_body_buffer_size 10M;" >> /etc/nginx/nginx.conf
echo "client_max_body_size 10M;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
    echo "#keepalive_timeout  0;" >> /etc/nginx/nginx.conf
    echo "keepalive_timeout  65;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
    echo "gzip  on;" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf
        echo "include /etc/nginx/sites-enabled/*;" >> /etc/nginx/nginx.conf
echo "}" >> /etc/nginx/nginx.conf
echo "" >> /etc/nginx/nginx.conf





echo "[Unit]" > /etc/systemd/system/nginx.service
echo "Description=A high performance web server and a reverse proxy server" >> /etc/systemd/system/nginx.service
echo "After=network.target" >> /etc/systemd/system/nginx.service
echo "" >> /etc/systemd/system/nginx.service
echo "[Service]" >> /etc/systemd/system/nginx.service
echo "Type=forking" >> /etc/systemd/system/nginx.service
echo "PIDFile=/run/nginx.pid" >> /etc/systemd/system/nginx.service
echo "ExecStartPre=/usr/sbin/nginx -t -q -g 'daemon on; master_process on;'" >> /etc/systemd/system/nginx.service
echo "ExecStart=/usr/sbin/nginx -g 'daemon on; master_process on;'" >> /etc/systemd/system/nginx.service
echo "ExecReload=/usr/sbin/nginx -g 'daemon on; master_process on;' -s reload" >> /etc/systemd/system/nginx.service
echo "ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid" >> /etc/systemd/system/nginx.service
echo "TimeoutStopSec=5" >> /etc/systemd/system/nginx.service
echo "KillMode=mixed" >> /etc/systemd/system/nginx.service
echo "" >> /etc/systemd/system/nginx.service
echo "[Install]" >> /etc/systemd/system/nginx.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/nginx.service


mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/nginx/sites-suspended
mkdir -p /etc/nginx/modules

echo "server {" > /etc/nginx/sites-enabled/000.conf
echo -e "\tlisten 80 default_server;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tserver_name _;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tindex index.php;" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tserver_name_in_redirect off;" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\troot /var/www/html/webcp/default;" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tlocation ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf|css|js)\$ {" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\texpires max;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t}" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tlocation / {" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\ttry_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t}" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\tlocation ~ \.php\$ {" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\tinclude snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\tfastcgi_pass unix:/run/php/php$phpVersion-fpm.sock;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\tfastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t\tfastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/000.conf
echo -e "\t}" >> /etc/nginx/sites-enabled/000.conf
echo "" >> /etc/nginx/sites-enabled/000.conf
echo "}" >> /etc/nginx/sites-enabled/000.conf




apt-get install -y apt-utils autoconf automake build-essential git libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev -y

cd /tmp
git clone --depth 1 -b v3/master --single-branch https://github.com/SpiderLabs/ModSecurity


cd ModSecurity
git submodule init
git submodule update
./build.sh
./configure
make
make install


rm -fr /tmp/nginx-1.15.8*

cd /tmp
git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git


cd /tmp
wget http://nginx.org/download/nginx-1.15.8.tar.gz
tar zxvf nginx-1.15.8.tar.gz

cd nginx-1.15.8
./configure --with-compat --add-dynamic-module=../ModSecurity-nginx
make modules
mkdir /etc/nginx/modules/
cp /tmp/nginx-1.15.8/objs/ngx_http_modsecurity_module.so /etc/nginx/modules/




mkdir /etc/nginx/modsec
cd /etc/nginx/modsec
wget https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended --no-check-certificate
cp modsecurity.conf-recommended modsecurity.conf
sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/nginx/modsec/modsecurity.conf



# rules
git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git
cd owasp-modsecurity-crs/

cp crs-setup.conf.example crs-setup.conf

















HostName=`cat /etc/hostname`

echo "server {" > /etc/nginx/sites-enabled/$HostName.conf
    echo "listen 80;" >> /etc/nginx/sites-enabled/$HostName.conf
    echo "server_name \$server_addr;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
    echo "return 301 http://${HostName}\$request_uri;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf



echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 80;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf

echo "        location /webcp {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                return 301 http://$HostName:10025;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf


echo "        location /webmail {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                return 301 http://$HostName:10030;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf

echo "        location /phpmyadmin {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                return 301 http://$HostName:10035;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf




echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "listen 10025;" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "listen [::]:10025;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "server_name $HostName localhost;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "root /var/www/html/webcp;" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "index index.php index.html index.htm index.nginx-debian.html;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "location / {" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "fastcgi_pass unix:/run/php/php$phpVersion-fpm.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
                echo "deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
        echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf


echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 20010;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen [::]:20010;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        root /home/$UserName/.editor;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "	index index.php index.html index.htm;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location / {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_pass unix:/run/php/php$phpVersion-fpm-$UserName.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 20001;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen [::]:20001;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        root /home/$UserName/.passwd;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "	index index.php index.html index.htm;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location / {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_pass unix:/run/php/php$phpVersion-fpm-$UserName.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 20020;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen [::]:20020;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        root /home/$UserName/.cron;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "	index index.php index.html index.htm;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location / {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_pass unix:/run/php/php$phpVersion-fpm-$UserName.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 10030;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen [::]:10030;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        root /var/www/html/rainloop;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "	index index.php;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location / {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_pass unix:/run/php/php$phpVersion-fpm.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "server {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen 10035;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        listen [::]:10035;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        server_name $HostName;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        root /var/www/html/phpmyadmin;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "	index index.php;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location / {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                try_files \$uri \$uri/ /index.php?\$args;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ \.php\$ {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_pass unix:/run/php/php$phpVersion-fpm.sock;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_send_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                fastcgi_read_timeout 300;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        location ~ /\.ht {" >> /etc/nginx/sites-enabled/$HostName.conf
echo "                deny all;" >> /etc/nginx/sites-enabled/$HostName.conf
echo "        }" >> /etc/nginx/sites-enabled/$HostName.conf
echo "}" >> /etc/nginx/sites-enabled/$HostName.conf
echo "" >> /etc/nginx/sites-enabled/$HostName.conf

systemctl enable nginx.service
systemctl start nginx.service
