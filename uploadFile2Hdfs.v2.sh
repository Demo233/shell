#!/bin/bash

#set java conf
export JAVA_HOME=/home/zyh/Documents/jdk1.8.0_161
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

#set hadoop conf
export HADOOP_HOME=/home/zyh/Documents/hadoop-2.7.3
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH

#日志文件存放的目录
src_dir=/home/zyh/Documents/bim-backupdata/

#待上传文件存放的目录
toupload_dir=/home/zyh/Documents/tmp4/


#日志文件上传到hdfs的根路径
hdfs_root_dir=/backup/20180426/

#打印环境变量信息
echo "envs: hadoop_home: $HADOOP_HOME"


#读取日志文件的目录，判断是否有需要上传的文件
echo "src_dir:"$src_dir
ls $src_dir | while read fileName
do
	date=`date +%Y_%m_%d_%H_%M_%S`
	#将文件移动到待上传目录并重命名
	#打印信息
	echo "moving $src_dir$fileName to $toupload_dir"bim_backup_data_"$fileName"_"$date"
	#mv $src_dir$fileName $toupload_dir"bim_backup_data_"$fileName"_"$date
	#压缩文件
	cd $src_dir
	tar -jcvp -f $toupload_dir"bim_backup_data_"$fileName"_"$date".tar.bz2" $fileName
	#将待上传的文件path写入一个列表文件willDoing
	echo $toupload_dir"bim_backup_data_"$fileName"_"$date".tar.bz2" >> $toupload_dir"willDoing."$date
	
done
#找到列表文件willDoing
ls $toupload_dir | grep will |grep -v "_COPY_" | grep -v "_DONE_" | while read line
do
	#打印信息
	echo "toupload is in file:"$line
	#将待上传文件列表willDoing改名为willDoing_COPY_
	mv $toupload_dir$line $toupload_dir$line"_COPY_"
	#读列表文件willDoing_COPY_的内容（一个一个的待上传文件名),此处的line 就是列表中的一个待上传文件的path
	cat $toupload_dir$line"_COPY_" |while read line
	do
		#打印信息
		echo "puting...$line to hdfs path.....$hdfs_root_dir"
		hadoop fs -put $line $hdfs_root_dir
	done	
	mv $toupload_dir$line"_COPY_"  $toupload_dir$line"_DONE_"
done

find $toupload_dir -type f -not \( -name '*_DONE_' -or -name '*_COPY_' \) -delete
