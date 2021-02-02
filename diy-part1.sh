#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# 修改默认配置：
sed -i '16,19d' include/target.mk
sed -i '15a\DEFAULT_PACKAGES:=base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd urandom-seed urngd block-mount coremark kmod-nf-nathelper kmod-nf-nathelper-extra kmod-ipt-raw libustream-openssl ca-certificates default-settings luci luci-compat wget-ssl curl luci-app-ddns luci-app-dockerman luci-app-hd-idle luci-app-nlbwmon luci-app-passwall luci-app-ssr-plus luci-app-qos luci-app-ramfree luci-app-samba luci-app-sfe luci-app-smartdns luci-app-upnp luci-app-vlmcsd bind-host ddns-scripts_aliyun ddns-scripts_dnspod' include/target.mk
sed -i '22,28d' target/linux/x86/Makefile
sed -i '21a\DEFAULT_PACKAGES += partx-utils mkf2fs fdisk e2fsprogs kmod-usb-hid kmod-mmc-spi kmod-sdhci kmod-igb vim htop lm-sensors autocore-x86 automount autosamba ddns-scripts_aliyun ddns-scripts_dnspod ca-certificates luci-app-sfe' target/linux/x86/Makefile
# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
# 删除默认密码
# sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/default-settings/files/zzz-default-settings
#
# 设置默认密码
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$ITQ3s4z.$3Nf3drPNkgqliJ7zl1fbs1:18508:0:99999:7:::/g' package/default-settings/files/zzz-default-settings
#
# 修改默认IP
sed -i 's/192.168.119.10/192.168.5.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
sed -i 's/OpenWrt/xsm/g' package/base-files/files/bin/config_generate
# 添加app
git clone https://github.com/smzhzy/openwrt-smartdns.git ./package/lean/smartdns

exit 0
