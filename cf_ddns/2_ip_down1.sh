#!/bin/bash
#         下载ip文件。

if [ -e ./cf_ddns/tmp/ ]; then
	rm -rf ./cf_ddns/tmp/
fi
if [ "$IP_SELECT" = "1" ]; then
	echo "下载cf官方ip文件"
	LATEST_URL=https://api.github.com/repos/XIU2/CloudflareSpeedTest/releases/latest
	latest_version() {
  		curl --silent $LATEST_URL | grep "tag_name" | cut -d '"' -f 4
}
	VERSION=$(latest_version)
	URL="https://github.com/XIU2/CloudflareSpeedTest/releases/download/$VERSION/CloudflareST_linux_amd64.tar.gz"
	wget -P ./cf_ddns/tmp/ ${PROXY}$URL
	tar -zxf ./cf_ddns/tmp/CloudflareST_linux_*.tar.gz -C ./cf_ddns/tmp/
	mv ./cf_ddns/tmp/ip.txt ./cf_ddns/tmp/ipv6.txt ./cf_ddns/
	rm -rf ./cf_ddns/tmp/
fi
