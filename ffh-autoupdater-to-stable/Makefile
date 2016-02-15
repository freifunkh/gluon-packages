include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-autoupdater-to-stable
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-autoupdater-to-stable
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Switches branch to stable.
  DEPENDS:=+gluon-core
endef

define Package/ffh-autoupdater-to-stable/description
	Switches branch to stable.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffh-autoupdater-to-stable/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ffh-autoupdater-to-stable))
