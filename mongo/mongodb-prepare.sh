# prepare
groupadd mongodb && useradd -m -g mongodb -s /bin/bash mongodb

cat >> /etc/security/limits.conf <<EOF
mongodb soft nproc 64000
mongodb hard nproc 64000
mongodb soft nofile 64000
mongodb hard nofile 64000
EOF

cat >> /etc/systemd/system/disable-transparent-huge-pages.service <<"EOF"
[Unit]
Description=Disable Transparent Huge Pages (THP)
DefaultDependencies=no
After=sysinit.target local-fs.target
Before=mongod.service

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo never | tee /sys/kernel/mm/transparent_hugepage/enabled > /dev/null'

[Install]
WantedBy=basic.target
EOF

systemctl daemon-reload
systemctl start disable-transparent-huge-pages
systemctl enable disable-transparent-huge-pages

cat /sys/kernel/mm/transparent_hugepage/enabled

mkdir -p /etc/tuned/virtual-guest-no-thp
cat >> /etc/tuned/virtual-guest-no-thp/tuned.conf <<"EOF"
[main]
include=virtual-guest

[vm]
transparent_hugepages=never
EOF
tuned-adm profile virtual-guest-no-thp

cat >> /etc/yum.repos.d/mongodb-org-4.4.repo <<"EOF"
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

#sudo yum install -y mongodb-org-4.4.0 mongodb-org-server-4.4.0 mongodb-org-shell-4.4.0 mongodb-org-mongos-4.4.0 mongodb-org-tools-4.4.0

# cat >> /etc/yum.conf <<"EOF"
# exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools
# EOF

echo "vm.zone_reclaim_mode = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 120" >> /etc/sysctl.conf
echo "vm.swappiness = 1" >> /etc/sysctl.conf
sysctl -p

sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
setenforce 0
# reboot
