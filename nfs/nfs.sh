yum install -y nfs-utils rpcbind
# 创建目录
mkdir /nfs
# 配置NFS目录
echo "/nfs    *(rw,sync,no_root_squash)" >> /etc/exports
exportfs -rv　　# 立即生效

systemctl enable --now nfs-server.service
showmount -e

# https://www.cnblogs.com/vincenshen/p/12447583.html
