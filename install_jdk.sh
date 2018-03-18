#/bin/bash
tar -zxvf /root/jdk-8u161-linux-x64.tar.gz -C ./
cat >> /etc/profile << EOF
export JAVA_HOME=/root/jdk1.8.0_161
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
source /etc/profile

service iptables stop
chkconfig iptables off

echo "" > /root/zookeeper/data/myid
echo $1 > /root/zookeeper/data/myid

cd /root/zookeeper/bin
./zkServer.sh start
