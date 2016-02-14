include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-dist-upgrade
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-dist-upgrade
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=A framework to delay the node update until a remote command is given.
  DEPENDS:=+gluon-core
endef

define Package/ffh-dist-upgrade/description
  The problem of the normal autoupdater is, that we have no exact control
  when each node downloads its updates. So we created a pre-update script,
  which connects to a specified server and waits until the server gives an
  update command expecially for this node. This remote command is ecdsa signed. 
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffh-dist-upgrade/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ffh-dist-upgrade))
