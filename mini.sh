#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#修改默认 IP为192.76.5.30
#sed -i 's/192.168.1.1/192.76.5.30/g' package/base-files/files/bin/config_generate
#取消bootstrap为默认主题
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
#删除原主题	
#rm -rf package/lean/luci-theme-argon

#添加主题
#git clone https://github.com/sypopo/luci-theme-atmaterial.git package/luci-theme-atmaterial
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/luci-theme-opentomato

#添加ssrplus
git clone https://github.com/fw876/helloworld.git package/helloworld
#添加passwall
#git clone https://github.com/yingdk/openwrt-package.git package/lienol
#添加hello world
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#添加Openclash
#git clone https://github.com/vernesong/OpenClash.git package/openclash
#添加koolproxyR
#git clone https://github.com/jefferymvp/luci-app-koolproxyR.git package/koolproxyR
#添加adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/adguardhome

#-清理feeds
./scripts/feeds clean
#-更新feeds
./scripts/feeds update -a
#-安装feeds
./scripts/feeds install -a
