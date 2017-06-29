include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-district-core
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_BUILD_DEPENDS := lua-cjson/host

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

PKG_CONFIG_DEPENDS += $(GLUON_I18N_CONFIG)

define Package/ffh-district-core
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
	$(call GluonBuildI18N,ffh-district-core,i18n)
endef

define Package/ffh-district-core/install
	mkdir -p $(1)/etc/config/
	$(CP) ./files/* $(1)/

	$(call GluonInstallI18N,ffh-district-core,$(1))
endef

$(eval $(call BuildPackage,ffh-district-core))
