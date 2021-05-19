- 修改内核参数

  > net.core.somaxconn = 20480
  > net.ipv4.tcp_max_syn_backlog = 512
  > vm.overcommit_memory = 1
  > vm.swappiness = 0

- 关闭THP，减少内存碎片