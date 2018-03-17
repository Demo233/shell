#!/bin/bash
#zyh2018年 03月 17日 星期六 19:03:23 CST 练习#if的使用


if [ $1 -eq 1 ]
	then
		echo "start"
	elif [ $1 -eq 2 ]
		then
			echo "stop"
	else
		echo "written in the strange"
fi
	
