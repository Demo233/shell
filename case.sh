#!/bin/bash
#zyh2018年 03月 17日 星期六 19:06:23 CST 练习#case的使用

read -p "enter a number" i
case $i in
1)
	echo "start"
	;;
2)
	echo "stopping"
	;;
*)
	echo "other"
esac
