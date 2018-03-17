#!/bin/bash
#zyh2018年 03月 17日 星期六 18:53:23 CST 练习#for循环

#for x in $1 $2 $3;do echo $x; done
#for x in $*;do echo $x;done
#for x in $@;do echo $x;done
#for x in "$*";do echo $x;done
#for((i=0;i<5;i++));do echo $i;done
for ((i=0;i<5;i++))
do
	echo $i
done
