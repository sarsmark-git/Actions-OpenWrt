#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#修改默认 IP为192.76.5.30
sed -i 's/192.168.1.1/192.76.5.30/g' package/base-files/files/bin/config_generate
#取消bootstrap为默认主题
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#修改默认主题为argon
#sed -i 's/luci-theme-bootstrap/luci-theme-opentomato/g' feeds/luci/collections/luci/Makefile
#sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci/Makefile
#删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
#修改默认密码
#修改shadow文件，位于package/base-files/files/etc/shadow
#删除原主题	
#rm -rf package/lean/luci-theme-argon

#删除部分目录
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf package/my
rm -rf package/luci-theme-opentomato
rm -rf package/luci-theme-opentomcat

#添加主题
#git clone https://github.com/sypopo/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/luci-theme-opentomato
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat package/luci-theme-opentomcat
#git clone https://github.com/jerrykuku/luci-theme-argon -b 18.06
#git clone https://github.com/jerrykuku/luci-theme-argon -b 19.07_stable

#添加ssrplus
git clone https://github.com/fw876/helloworld.git package/my/helloworld
#添加passwall
git clone https://github.com/kenzok8/openwrt-packages package/my/openwrt-packages
git clone https://github.com/kenzok8/small.git package/my/small
#src-git lienol https://github.com/sarsmark-git/lienol-openwrt-package
#添加jerrykuku-hello world
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/my/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/my/luci-app-vssr
#添加leo-jo-hello world
#git clone https://github.com/yingdk/diy.git package/my/diy
#git clone https://github.com/yingdk/luci-app-vssr-plus.git package/my/luci-app-vssr-plus
#添加Openclash
git clone https://github.com/vernesong/OpenClash.git -b master package/my/openclash
#添加koolproxyR
git clone https://github.com/jefferymvp/luci-app-koolproxyR.git package/my/koolproxyR
#添加adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/my/adguardhome
#添加openappfilter
git clone https://github.com/destan19/openappfilter package/my/openappfilter
#添加smartdns
WORKINGDIR="`pwd`/feeds/packages/net/smartdns"
mkdir $WORKINGDIR -p
rm $WORKINGDIR/* -fr
wget https://github.com/pymumu/openwrt-smartdns/archive/master.zip -O $WORKINGDIR/master.zip
unzip $WORKINGDIR/master.zip -d $WORKINGDIR
mv $WORKINGDIR/openwrt-smartdns-master/* $WORKINGDIR/
rmdir $WORKINGDIR/openwrt-smartdns-master
rm $WORKINGDIR/master.zip


#输入完之后需要你回车一次
LUCIBRANCH="lede"
WORKINGDIR="`pwd`/feeds/luci/applications/luci-app-smartdns"
mkdir $WORKINGDIR -p
rm $WORKINGDIR/* -fr
wget https://github.com/pymumu/luci-app-smartdns/archive/${LUCIBRANCH}.zip -O $WORKINGDIR/${LUCIBRANCH}.zip
unzip $WORKINGDIR/${LUCIBRANCH}.zip -d $WORKINGDIR
mv $WORKINGDIR/luci-app-smartdns-${LUCIBRANCH}/* $WORKINGDIR/
rmdir $WORKINGDIR/luci-app-smartdns-${LUCIBRANCH}
rm $WORKINGDIR/${LUCIBRANCH}.zip


#输入完之后需要你回车一次

sed -i 's/LUCI_DEPENDS:=+luci-compat +smartdns/LUCI_DEPENDS:=+smartdns/g' feeds/luci/applications/luci-app-smartdns/Makefile
sed -i 's/include ..\/..\/luci.mk/include $(TOPDIR)\/feeds\/luci\/luci.mk/g' feeds/luci/applications/luci-app-smartdns/Makefile

#删除jerrykuku-helloworld+ssrplus冲突文件
rm -rf package/my/luci-app-vssr/root/etc/china_ssr.txt
rm -rf package/my/luci-app-vssr/root/etc/dnsmasq.oversea/oversea_list.conf
rm -rf package/my/luci-app-vssr/root/etc/dnsmasq.ssr/gfw_base.conf
rm -rf package/my/luci-app-vssr/root/etc/dnsmasq.ssr/gfw_list.conf

#移除不用软件包
rm -rf package/my/openwrt-packages/luci-app-openclash
#rm -rf package/my/openwrt-packages/luci-app-smartdns
rm -rf package/my/openwrt-packages/luci-app-ssr-plus
rm -rf package/my/openwrt-packages/luci-theme-opentomato
rm -rf package/my/openwrt-packages/luci-theme-opentomcat

#-清理feeds
#./scripts/feeds clean
#-更新feeds
./scripts/feeds update -a

#-安装feeds
./scripts/feeds install -a

#二次编译：
#cd lede
#git pull
#./scripts/feeds update -a && ./scripts/feeds install -a
#make defconfig
#make -j8 download
#make -j$(($(nproc) + 1)) V=s

#如果需要重新配置：

#rm -rf ./tmp && rm -rf .config
#make menuconfig
#make -j$(($(nproc) + 1)) V=s
