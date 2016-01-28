################################################################################
#
# golang-gb
#
################################################################################

GOLANG_GB_VERSION = 0.4.0
GOLANG_GB_TAG = v$(GOLANG_GB_VERSION)
GOLANG_GB_SITE = $(call github,constabulary,gb,$(GOLANG_GB_TAG))
GOLANG_GB_LICENSE = MIT

GOLANG_GB_ENV = GOPATH=$(@D)

define HOST_GOLANG_GB_EXTRACT_CMDS
	mkdir -p $(@D)/src/github.com/constabulary
	tar xvaf $(DL_DIR)/golang-gb-$(GOLANG_GB_VERSION).tar.gz -C $(@D)
	mv $(@D)/gb-$(GOLANG_GB_VERSION) $(@D)/src/github.com/constabulary/gb
endef

define HOST_GOLANG_GB_BUILD_CMDS
	env -i $(GOLANG_GB_ENV) $(GO_HOST_BINARY) install -v github.com/constabulary/gb/cmd/gb
	env -i $(GOLANG_GB_ENV) $(GO_HOST_BINARY) install -v github.com/constabulary/gb/cmd/gb-vendor
endef

define HOST_GOLANG_GB_INSTALL_CMDS
	$(INSTALL) -m 755 $(@D)/bin/gb $(HOST_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/bin/gb-vendor $(HOST_DIR)/usr/bin
endef

$(eval $(host-generic-package))
