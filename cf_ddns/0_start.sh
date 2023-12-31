#!/bin/bash
##版本：V1.3
	#主程序为0_start.sh。
 
###################################################################################################
#------------------------------------------工作模式配置---------------------------------------------
# --工作路径--
#   cf_ddns_start.sh在cf_ddns里
#   本命令没有运行在绝对根目录/,而是相对路径./cf_ddns/0_start.sh
#   如果cf_ddns文件保存在根目录，运行命令/cf_ddns/0_start.sh，不填或者填/；如果保存在其他目录下，运行/xxxxxxxx/cf_ddns/0_start.sh,填/xxxxxxxx
workdir=
# --初始化--
#   如果是开机第一次运行的话，将进行初始化；或者强制运行初始化
#   是否每次运行都强制检查并下载所需依赖及文件;flag=1 是。默认不填,开机第一次运行的话，将进行初始化
flag=
# --运行模式--
#	ipv4 or ipv6 默认为：ipv4
#	指定工作模式为ipv4还是ipv6。如果为ipv6，请在文件夹下添加ipv6.txt
#	ipv6.txt在CloudflareST工具包里，下载地址：https://github.com/XIU2/CloudflareSpeedTest/releases
IP_ADDR=ipv4
#
# --使用ip文件选择--
#	CF官方ip地址调用https://github.com/XIU2/CloudflareSpeedTest/releases。
#	CF反代ip地址调用https://zip.baipiao.eu.org。
#	IP_SELECT=1 调用官方ip；IP_SELECT=2 调用反代ip。默认官方ip
IP_SELECT=1
#	是否每次运行脚本进行ip地址更新。IP_UPDATE=1，是;不填，不更新。
IP_UPDATE=
#
# --填写需要DDNS的完整域名--
#	支持多域名:域名需要填写在括号中，每个域名之间用“空格”相隔。
#	例如：（cdn.test.com） 或者 （cdn1.test.com cdn2.test.com cdn3.test.com）
hostname=()
#
#------------------------------------------cloudflare配置------------------------------------------
# --cloudflare账号邮箱--
x_email=
#
# --区域ID--
zone_id=
#
# --Global API Key--
api_key=
#
#-----------------------------------openwrt科学上网插件配置------------------------------------------
# --优选节点时是否自动停止科学上网服务--
#	true=自动停止 false=不停止 默认为 true
pause=true
#
# --客户端代码--
#	填写openwrt使用的是哪个科学上网客户端，填写对应的“数字”  默认为 1  客户端为passwall
#	1=passwall 2=passwall2 3=ShadowSocksR Plus+ 4=clash 5=openclash 6=bypass
clien=1
#
# --延时执行--
#	填写重启科学上网服务后，需要等多少秒后才开始更新DNS 单位：秒
#	根据自己的网络情况来填写 推荐 15
sleepTime=15
#
#--------------------------------------CloudflareST配置---------------------------------------------
# --测速地址--
#	有自己的测速地址可替换，若不填写则使用默认地址
CFST_URL=
#
# --测速地址端口--
#    指定测速端口；延迟测速/下载测速时使用的端口；(默认 443 端口)
#    必须要填
CFST_TP=443
#
# --测速模式--
#    指定测速模式；httping(默认TCPing,默认则留空)
#    注意：HTTPing 本质上也算一种 网络扫描 行为，因此如果你在服务器上面运行，需要降低并发(-n)，否则可能会被一些严格的商家暂停服务。(详细参考：https://github.com/XIU2/CloudflareSpeedTest中-httping参数)
CFST_STM=
#
# --有效状态代码--
#    HTTPing 延迟测速时网页返回的有效 HTTP 状态码，仅限一个；(默认 200 301 302)
httping_code=
#
# --匹配指定地区--
#    地区名为当地机场三字码，英文逗号分隔，支持小写，支持 Cloudflare、AWS CloudFront，仅 HTTPing 模式可用；(默认 所有地区)
#    例如:HKG,KHH,NRT,LAX,SEA,SJC,FRA,MAD
cfcolo=

# --测速线程数量--
#	越多测速越快，性能弱的设备 (如路由器) 请勿太高；(默认 200 最多 1000 )
CFST_N=200
#
# --延迟测速次数--
#	单个 IP 延迟测速次数，为 1 时将过滤丢包的IP，TCP协议；(默认 4 次 )
CFST_T=4
#
# --下载测速数量--
#	延迟测速并排序后，从最低延迟起下载测速的数量；(默认 10 个)
CFST_DN=10
#
# --平均延迟上限--
#	只输出低于指定平均延迟的 IP，可与其他上限/下限搭配；(默认9999 ms 这里推荐配置300 ms)
CFST_TL=300
#
# --平均延迟下限--
#	只输出高于指定平均延迟的 IP，可与其他上限/下限搭配、过滤假墙 IP；(默认 0 ms 这里推荐配置40)
CFST_TLL=0
#
# --丢包几率上限--
#	只输出低于/等于指定丢包率的 IP，范围 0.00~1.00，0 过滤掉任何丢包的 IP；(默认 1.00 推荐0.2)
CFST_TLR=0.2
#
# --下载速度下限--
#	只输出高于指定下载速度的 IP，凑够指定数量 [-dn] 才会停止测速；(默认 0.00 MB/s 这里推荐5.00MB/s)
CFST_SL=5
#
#------------------------------------------推送设置------------------------------------------------
#           ----TG推送设置----
#	（填写即为开启推送，未填写则为不开启）
#
# --TG机器人token--
#	例如：123456789:ABCDEFG...
telegramBotToken=
#
# --用户ID或频道、群ID--
#	例如：123456789
telegramBotUserId=
#
# --tg推送代理域名--
#	可用于本地没有科学环境，想要调用tgAPI需要自建反向代理API域名 （待更新教程）
Proxy_TG=
#
#        ----TG推送设置结束----
#--------------------------------------------结束----------------------------------------------------
###################################################################################################

if [[ -n $workdir ]]; then
    cd $workdir
fi

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
