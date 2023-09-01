#!/bin/bash
#         下载cf反代ip文件。

if [ "$IP_UPDATE" = "1" ] || [ ! -f ./cf_ddns/ip2/ip.txt ]; then
	echo "下载cf反代ip文件"
	if [ -e ./cf_ddns/tmp/ ]; then
		rm -rf ./cf_ddns/tmp/*
	else
		mkdir ./cf_ddns/tmp/
	fi
	if [ ! -e ./cf_ddns/ip2/ ]; then
		mkdir ./cf_ddns/ip2/
	fi
	# 定义下载链接和保存路径
	download_url="https://zip.baipiao.eu.org/"
	save_path="./cf_ddns/tmp/txt.zip"
	extracted_folder="./cf_ddns/tmp/txt"  # 解压后的文件夹路径
	# 定义最大尝试次数
	max_attempts=10
	current_attempt=1
	# 循环尝试下载
	while [ $current_attempt -le $max_attempts ]
	do
    		# 下载文件
		wget ${download_url} -O $save_path

    		# 检查是否下载成功
    		if [ $? -eq 0 ]; then
        		break
    		else
        		echo "Download attempt $current_attempt failed."
        		current_attempt=$((current_attempt+1))
    		fi
	done
	# 检查是否下载成功
	if [ $current_attempt -gt $max_attempts ]; then
    		echo "Failed to download the file after $max_attempts attempts."
	else
    		# 删除原来的txt文件夹内容
    		rm -rf $extracted_folder/*

    		# 解压文件
    		unzip $save_path -d $extracted_folder

    		# 删除压缩包
    		rm $save_path

    		echo "File downloaded and unzipped successfully."
		# 合并文件为ip.txt
    		# 合并所有含有-1-443.txt的文本文件到一个新文件中
    		merged_file="./cf_ddns/tmp/merged_ip.txt"
    		cat $extracted_folder/*-1-443.txt > $merged_file
		# 移动到ip.txt到程序总目录
    		# 将合并后的文件移动到/root/CloudflareST/ip.txt并覆盖原文件
    		mv -f "$merged_file" "./cf_ddns/ip2/ip.txt"
    		echo "Merged text files containing '-1-443.txt' moved and renamed as 'ip.txt' in ./cf_ddns/ip2."
	fi
	rm -rf ./cf_ddns/tmp/
fi

if [ "$IP_SELECT" = "2" ]; then
	cp -f ./cf_ddns/ip2/ip.txt ./cf_ddns/
fi
