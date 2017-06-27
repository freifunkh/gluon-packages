include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-site-adjust-migrate
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/ffh-site-adjust-migrate
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Migrate gluon nodes to ffh-site-adjust districts by asking a http server for the right district
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call Build/Compile/Default)
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/ffh-site-adjust-migrate/install
	mkdir -p $(1)/etc/config/
	$(CP) ./files/* $(1)/
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
endef

$(eval $(call BuildPackage,ffh-site-adjust-migrate))
