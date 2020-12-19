systemctl stop firewalld
systemctl disable firewalld

sed -i "s/server/#server/" /etc/chrony.conf
sed -i "/server 3.centos.pool.ntp.org iburst/a server 192.168.33.98 iburst\nserver 192.168.33.92 iburst" /etc/chrony.conf

systemctl restart chronyd