zk_path=/home/zookeeper/node
zk_home=/home/zookeeper
myid=2
mkdir -p ${zk_path}/{data,log,conf}
cat >> ${zk_path}/conf/zoo.cfg <<EOF
tickTime=2000
dataDir=${zk_path}/data
dataLogDir=${zk_path}/log
clientPort=2181
initLimit=5
syncLimit=2
server.1=node01:2888:3888
server.2=node02:2888:3888
server.3=node03:2888:3888
EOF
echo ${myid} > ${zk_path}/data/myid
touch ${zk_path}/data/initialize


#bin/zkServer.sh start node01/conf/zoo.cfg
nohup java -cp zookeeper.jar:${zk_home}/lib/*:conf org.apache.zookeeper.server.quorum.QuorumPeerMain ${zk_path}/conf/zoo.cfg &> ${zk_path}/log/zk.log &