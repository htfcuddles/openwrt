#
# Copyright (C) 2020 SiYu Wu <wu.siyu@hotmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-chinadns-ng
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=SiYu Wu <wu.siyu@hotmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-chinadns-ng
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for chinadns-ng
	PKGARCH:=all
	DEPENDS:=+chinadns-ng
endef

define Package/luci-app-chinadns-ng/description
	LuCI Support for chinadns-ng.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-chinadns-ng/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-chinadns-ng ]; then
		( . /etc/uci-defaults/luci-chinadns-ng ) && \
		rm -f /etc/uci-defaults/luci-chinadns-ng
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Package/luci-app-chinadns-ng/postrm
#!/bin/sh
rm -f /tmp/luci-indexcache
exit 0
endef

define Package/luci-app-chinadns-ng/conffiles
/etc/config/chinadns-ng
endef

define Package/luci-app-chinadns-ng/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/luci/controller/chinadns-ng.lua $(1)/usr/lib/lua/luci/controller/chinadns-ng.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/luci/model/cbi/chinadns-ng.lua $(1)/usr/lib/lua/luci/model/cbi/chinadns-ng.lua
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/luci-chinadns-ng $(1)/etc/uci-defaults/luci-chinadns-ng
endef

$(eval $(call BuildPackage,luci-app-chinadns-ng))
