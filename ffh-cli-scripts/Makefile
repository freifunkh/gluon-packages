include $(TOPDIR)/rules.mk

PKG_NAME:=ffh-cli-scripts
PKG_VERSION:=2

include $(TOPDIR)/../package/gluon.mk

define Package/ffh-cli-scripts
  TITLE:=Custom scripts used in Freifunk Hannover
  DEPENDS:=+gluon-core
endef

$(eval $(call BuildPackageGluon,ffh-cli-scripts))
