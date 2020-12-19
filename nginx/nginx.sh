groupadd nginx && useradd -g nginx -s /bin/bash nginx
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
yum install -y lrzsz

echo "net.ipv4.tcp_syn_retries = 2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_synack_retries = 2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 600" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes = 3" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl = 15" >> /etc/sysctl.conf
echo "net.ipv4.tcp_retries1= 3" >> /etc/sysctl.conf
echo "net.ipv4.tcp_retries2 = 10" >> /etc/sysctl.conf
echo "net.ipv4.tcp_orphan_retries = 7" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout = 20" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets = 36000" >> /etc/sysctl.conf
echo "vm.swappiness = 0" >> /etc/sysctl.conf
sysctl -p

su nginx -c "mkdir /home/nginx/{conf,logs,client_body,proxy,fastcgi,lock,run}"

yum install -y gcc gcc-c++
yum install -y pcre pcre-devel
yum install -y openssl openssl-devel

cd /home/nginx && wget https://nginx.org/download/nginx-1.18.0.tar.gz
tar zxf nginx-1.18.0.tar.gz && cd nginx-1.18.0

./configure \
--group=nginx \
--user=nginx \
--prefix=/home/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/home/nginx/conf/nginx.conf \
--pid-path=/home/nginx/run/nginx.pid \
--error-log-path=/home/nginx/logs/error.log \
--http-log-path=/home/nginx/logs/access.log \
--http-client-body-temp-path=/home/nginx/client_body \
--http-proxy-temp-path=/home/nginx/proxy \
--http-fastcgi-temp-path=/home/nginx/fastcgi \
--lock-path=/home/nginx/lock \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--with-pcre

cat >> /etc/security/limits.conf <<EOF
* soft nofile 65535
* hard nofile 65535
EOF

# reboot

make
make install

cat >> /etc/systemd/system/nginx.service <<"EOF"
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
User=nginx
Group=nginx
PIDFile=/home/nginx/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

setcap cap_net_bind_service=+eip /usr/sbin/nginx

systemctl daemon-reload
systemctl enable nginx

# Configuration summary
#   + using system PCRE library
#   + using system OpenSSL library
#   + using system zlib library

#   nginx path prefix: "/home/nginx"
#   nginx binary file: "/usr/sbin/nginx"
#   nginx modules path: "/home/nginx/modules"
#   nginx configuration prefix: "/home/nginx/conf"
#   nginx configuration file: "/home/nginx/conf/nginx.conf"
#   nginx pid file: "/home/nginx/run/nginx.pid"
#   nginx error log file: "/home/nginx/logs/error.log"
#   nginx http access log file: "/home/nginx/logs/access.log"
#   nginx http client request body temporary files: "/home/nginx/client_body"
#   nginx http proxy temporary files: "/home/nginx/proxy"
#   nginx http fastcgi temporary files: "/home/nginx/fastcgi"
#   nginx http uwsgi temporary files: "uwsgi_temp"
#   nginx http scgi temporary files: "scgi_temp"