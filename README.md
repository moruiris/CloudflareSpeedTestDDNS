# CloudflareSpeedTestDDNS


### openwrt使用
- 在计划任务中添加下面代码：
- 0 3 * * * bash ./cf_ddns/0_start.sh
- 我用的是下面这个，可以前后进行官方ip优选和反代ip优选：
- 0 3 * * * bash ./cf_ddns/0_start1.sh && bash ./cf_ddns/0_start2.sh

### 感谢名单（向他们学习才有这个项目）
- [lee1080/CloudflareSpeedTestDDNS](https://github.com/lee1080/CloudflareSpeedTestDDNS)
- [ydl898898/cloudflareDDNS](https://github.com/ydl898898/cloudflareDDNS)
