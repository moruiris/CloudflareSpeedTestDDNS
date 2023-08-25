#!/bin/bash

if [[ -n $workdir ]]; then
    cd $workdir
fi

source config.conf;

source ./cf_ddns/1_check.sh

case $IP_SELECT in
    1)
        source ./cf_ddns/2_ip_down1.sh
        ;;
    2)
        source ./cf_ddns/2_ip_down2.sh
        ;;
    *)
        echo "未选择ip文件，不进行最新ip文件下载"
        ;;
esac

source ./cf_ddns/3_ddns_cloudflare.sh

source ./cf_ddns/4_push.sh

exit 0;
