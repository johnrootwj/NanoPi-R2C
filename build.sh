#!/bin/bash
cd openwrt
make tools/compile -j1 V=s
make toolchain/compile -j1 V=s
make target/compile -j1 V=s IGNORE_ERRORS=1
make diffconfig
make package/compile -j1 V=s IGNORE_ERRORS=1
make package/index
chmod 777 ../base_files/* -R
cp -ri ../base_files/* files/
mkdir -p files/etc/uci-defaults/
cp ../scripts/init-settings.sh files/etc/uci-defaults/99-init-settings
mkdir -p files/etc/opkg
cp ../configs/opkg/distfeeds-packages-server.conf files/etc/opkg/distfeeds.conf.server
mkdir -p files/etc/opkg/keys
cp ../configs/opkg/1035ac73cc4e59e3 files/etc/opkg/keys/1035ac73cc4e59e3
make package/install -j1 V=s
make target/install -j1 V=s
make checksum
