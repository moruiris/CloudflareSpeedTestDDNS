#!/bin/bash
##用于CloudflareSpeedTestDDNS执行情况推送。

echo "TG将推送的内容如下：";

cat $informlog

message_text=$(echo "$(sed "$ ! s/$/\\\n/ " ./cf_ddns/informlog | tr -d '\n')")

##tg推送##
if [[ -z ${Proxy_TG} ]]; then
	tgapi="https://api.telegram.org"
else
	tgapi=$Proxy_TG
fi

TGURL="$tgapi/bot${telegramBotToken}/sendMessage"

if [[ -z ${telegramBotToken} ]]; then
	echo "未配置TG推送"
else
	res=$(timeout 20s curl -s -X POST $TGURL -H "Content-type:application/json" -d '{"chat_id":"'$telegramBotUserId'", "parse_mode":"HTML", "text":"'$message_text'"}')
	if [ $? == 124 ];then
		echo 'TG_api请求超时,请检查网络是否重启完成并是否能够访问TG'
	fi
	resSuccess=$(echo "$res" | jq -r ".ok")
	if [[ $resSuccess = "true" ]]; then
		echo "TG推送成功";
	else
		echo "TG推送失败，请检查网络或TG机器人token和ID";
	fi
fi

exit 0;
