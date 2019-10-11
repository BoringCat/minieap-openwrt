include $(TOPDIR)/rules.mk

PKG_NAME:=minieap
PKG_VERSION:=0.92.1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/minieap-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/updateing/minieap.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)


include $(INCLUDE_DIR)/package.mk

define Package/minieap
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A standard EAP client with EAP-MD5-Challenge algorithm
	URL:=https://github.com/updateing/minieap
endef

define Package/minieap/description
	This is an EAP client that implements the standard EAP-MD5-Challenge algorithm.
	It supports plug-in to modify the standard data package to authenticate the special server.
endef

define Package/minieap/conffiles
	/etc/minieap.conf
endef

define Build/Compile
	#$(Build/Compile/$(PKG_NAME))
	$(SED) 's/ENABLE_ICONV.*/ENABLE_ICONV := false/g' $(PKG_BUILD_DIR)/config.mk
	$(SED) 's/ENABLE_GBCONV.*/ENABLE_GBCONV := true/g' $(PKG_BUILD_DIR)/config.mk
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		CPPFLAGS="$(TARGET_CPPFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) -ldl"
endef

define Package/minieap/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minieap $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
