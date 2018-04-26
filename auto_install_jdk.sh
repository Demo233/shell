#!/bin/bash
SERVERS="192.168.0.102"
PASSWORD="1"
INDEX=1

auto_ssh(){
	expect -c "set timeout -1;
        spawn ssh-copy-id root@$1;
        expect {
            *(yes/no)* {send -- yes\r;exp_continue;}
            *password:* {send -- $2\r;exp_continue;}
            eof {exit 0;}
        }";
}

each_server(){
    for SERVER in $SERVERS
    do
        auto_ssh $SERVER $PASSWORD
    done
}

each_server

#发送jdk安装包
scp $HOME/Documents/jdk-8u161-linux-x64.tar.gz root@$SERVER:/root
#发送jdk安装命令并自动配置环境变量的脚本1
scp $HOME/workspace/shell/install_jdk.sh root@$SERVER:/root
#发送zookeeper包
scp -r /home/zyh/zookeeper root@$SERVER:/root

#脚本1
ssh root@$SERVER /root/install_jdk.sh $INDEX

