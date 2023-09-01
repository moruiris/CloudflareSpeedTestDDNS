#!/bin/bash
#         下载cf官方ip文件。

if [ "$IP_UPDATE" = "1" ] || [ ! -f ./cf_ddns/ip1/ip.txt ] || [ ! -f ./cf_ddns/ip1/ipv6.txt ]; then
	echo "下载cf官方ip文件"
	if [ -e ./cf_ddns/tmp/ ]; then
		rm -rf ./cf_ddns/tmp/
	fi
	if [ ! -e ./cf_ddns/ip1/ ]; then
		mkdir ./cf_ddns/ip1/
	fi
	LATEST_URL=https://api.github.com/repos/XIU2/CloudflareSpeedTest/releases/latest
	latest_version() {
  		curl --silent $LATEST_URL | grep "tag_name" | cut -d '"' -f 4
  		}
	VERSION=$(latest_version)
	URL="https://github.com/XIU2/CloudflareSpeedTest/releases/download/$VERSION/CloudflareST_linux_amd64.tar.gz"
	wget -P ./cf_ddns/tmp/ ${PROXY}$URL
	tar -zxf ./cf_ddns/tmp/CloudflareST_linux_*.tar.gz -C ./cf_ddns/tmp/
	mv -f ./cf_ddns/tmp/ip.txt ./cf_ddns/tmp/ipv6.txt ./cf_ddns/ip1/
	rm -rf ./cf_ddns/tmp/
fi

if [ "$IP_SELECT" = "1" ]; then
	cp -f ./cf_ddns/ip1/ip.txt ./cf_ddns/ip1/ipv6.txt ./cf_ddns/
fi
