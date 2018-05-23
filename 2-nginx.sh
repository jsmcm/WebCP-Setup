#!/bin/bash


##################
#
# nginx 
#
##################

cd /tmp
mkdir webcp
chown www-data.www-data webcp
chmod 770 webcp

wget http://nginx.org/download/nginx-1.13.9.tar.gz
tar zxf nginx-1.13.9.tar.gz
cd nginx-1.13.9




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
            --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'
        

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
mkdir -p /etc/nginx/modules

rm -fr /tmp/nginx-1.13.9*

systemctl enable nginx.service
systemctl start nginx.service









