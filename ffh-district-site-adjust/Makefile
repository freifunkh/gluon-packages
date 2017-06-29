include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-district-site-adjust
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_BUILD_DEPENDS := lua-cjson/host

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-district-site-adjust
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=UI for changing the node-config
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffh-district-site-adjust/install
	mkdir -p $(1)/etc/config/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ffh-district-site-adjust))
