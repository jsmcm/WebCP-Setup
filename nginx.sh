#!/bin/bash


##################
#
# nginx 
#
##################

phpVersion=`php -v | grep PHP\ 7 | cut -d ' ' -f 2 | cut -d '.' -f1,2`

apt-get install dpkg-dev build-essential zlib1g-dev libpcre3 libpcre3-dev unzip -y
apt-get install uuid-dev uuid -y

mkdir -p /etc/nginx/pagespeed
cd /etc/nginx/pagespeed

NPS_VERSION=1.13.35.2-stable
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})  # extracts to psol/



cd /usr/local/src
git clone --recursive https://github.com/google/ngx_brotli.git

cd /tmp


#git clone https://github.com/openssl/openssl.git
#cd openssl
#git checkout OpenSSL_1_1_1-stable
apt-get install libssl-dev -y

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
	    --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' \
            --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' \
	    --add-module=/etc/nginx/pagespeed/incubator-pagespeed-ngx-${NPS_VERSION}/ ${PS_NGX_EXTRA_FLAGS} \
	    --add-module=/usr/local/src/ngx_brotli

make


make install

mkdir -p /var/lib/nginx 
mkdir -p /var/cache/nginx/client_temp

mkdir -p /var/cache/ngx_pagespeed_cache


cd /etc/nginx
mkdir snippets
cd snippets

mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/nginx/sites-suspended
mkdir -p /etc/nginx/modules


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
HostName="$(echo -e "${HostName}" | tr -d '[:space:]')"

/tmp/nginx_conf.sh

chown www-data.www-data /var/cache/ngx_pagespeed_cache

systemctl enable nginx.service
systemctl start nginx.service
