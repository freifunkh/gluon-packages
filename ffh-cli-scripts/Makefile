include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-cli-scripts
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-cli-scripts
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=A framework to delay the node update until a remote command is given.
  DEPENDS:=+gluon-core
endef

define Package/ffh-dist-upgrade/description
  Custom scripts used in Freifunk Hannover
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffh-cli-scripts/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ffh-cli-scripts))
