echo "vm.swappiness = 0" >> /etc/sysctl.conf
sysctl -p

swapoff -a

# 注释swap分区,永久生效
vim /etc/fstab