include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-autoupdater-to-domain
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-autoupdater-to-domain
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Sets domain value and calls gluon-reconfigure.
  DEPENDS:=+gluon-core
endef

define Package/ffh-autoupdater-to-domain/description
  Sets domain value and calls gluon-reconfigure.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffh-autoupdater-to-domain/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ffh-autoupdater-to-domain))
