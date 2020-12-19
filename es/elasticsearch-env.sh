echo "vm.swappiness = 0" >> /etc/sysctl.conf
echo "vm.max_map_count = 655360" >> /etc/sysctl.conf
sysctl -p