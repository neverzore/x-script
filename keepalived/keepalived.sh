yum install -y keepalived
firewall-cmd --direct --permanent --add-rule ipv4 filter INPUT 0 --in-interface ens192 --destination 224.0.0.18 --protocol vrrp -j ACCEPT
firewall-cmd --direct --permanent --add-rule ipv4 filter OUTPUT 0 --out-interface ens192 --destination 224.0.0.18 --protocol vrrp -j ACCEPT
firewall-cmd --reload

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf
sysctl -p