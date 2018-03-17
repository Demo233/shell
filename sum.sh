#!/bin/bash
#author:zyh
#date:2018年 03月 17日 星期六 17:57:42 CST

function fsum(){
	echo $1,$2;
	return $(($1+$2));
}
fsum 2 5;
echo $?;
