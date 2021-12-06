#!/bin/bash
git clone https://github.com/coolsnowwolf/lede -b master openwrt
cd openwrt
mkdir customfeeds
git clone --depth=1 https://github.com/coolsnowwolf/packages customfeeds/packages
git clone --depth=1 https://github.com/coolsnowwolf/luci customfeeds/luci
chmod +x ../scripts/*.sh
../scripts/hook-feeds.sh
cd package/lean/autocore/files/arm
sed -i '/Load Average/i\\t\t<tr><td width="33%"><%:Telegram %></td><td><a href="https://f.592fq.com"><%:交流群%></a></td></tr>' index.htm
cd ../../../../../
./scripts/feeds install -a
cd ..
[ -e files ] && mv files openwrt/files
mv ./configs/lean/lean_stable.config/.config
cd openwrt
../scripts/lean.sh
../scripts/preset-clash-core.sh armv8
../scripts/preset-terminal-tools.sh
make defconfig
echo "CONFIG_ALL_NONSHARED=y" >> .config
../scripts/modify_config.sh
make download -j8