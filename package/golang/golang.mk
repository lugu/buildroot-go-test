################################################################################
#
# golang
#
################################################################################

GOLANG_VERSION = 1.5.3
GOLANG_SOURCE = go$(GOLANG_VERSION).src.tar.gz
GOLANG_SITE = https://storage.googleapis.com/golang
GOLANG_LICENSE = BSD-3c
GOLANG_LICENSE_FILES = LICENSE
GOLANG_EXTRA_SOURCE = go1.4.2.src.tar.gz
HOST_GOLANG_EXTRA_DOWNLOADS = https://storage.googleapis.com/golang/$(GOLANG_EXTRA_SOURCE)
GOLANG_SUBDIR = go

#
# Environment used to bootstrap
#
GOLANG_BOOTSTRAP_DIR = $(@D)/bootstrap
GOLANG_BOOTSTRAP_GO = $(GOLANG_BOOTSTRAP_DIR)/go
GOLANG_BOOTSTRAP_BIN = $(GOLANG_BOOTSTRAP_GO)/bin
GOLANG_BOOTSTRAP_ENV = GOBIN=$(GOLANG_BOOTSTRAP_BIN) PATH=$(BR_PATH)

#
# Environment used to build
#
GOLANG_GOROOT_FINAL = $(HOST_DIR)/usr/lib/go
GOLANG_BUILD_ENV = PATH=$(GOLANG_BOOTSTRAP_BIN):$(BR_PATH) \
	GOROOT_FINAL=$(GOLANG_GOROOT_FINAL) \
	GOROOT_BOOTSTRAP=$(GOLANG_BOOTSTRAP_GO)

#
# Packages can use GO_HOST_BINARY to call the go program
#
GO_HOST_BINARY = $(HOST_DIR)/usr/bin/go

#
# Extracts bootstraping and host compilers
#
define HOST_GOLANG_EXTRACT_CMDS
	mkdir -p $(GOLANG_BOOTSTRAP_BIN)
	tar xvaf $(BR2_DL_DIR)/$(GOLANG_EXTRA_SOURCE) -C $(GOLANG_BOOTSTRAP_DIR)
	tar xvaf $(BR2_DL_DIR)/$(GOLANG_SOURCE) -C $(@D)
endef

#
# Build bootstraping compiler before the host compiler.
#
define HOST_GOLANG_BOOTSTRAP
	cd $(GOLANG_BOOTSTRAP_GO)/src; env -i $(GOLANG_BOOTSTRAP_ENV) ./make.bash
endef

HOST_GOLANG_PRE_BUILD_HOOKS += HOST_GOLANG_BOOTSTRAP

#
# Compile the host compiler with the envionment pointing to the bootstraping
# compiler previously built
#
define HOST_GOLANG_BUILD_CMDS
	cd $(HOST_GOLANG_SRCDIR)/src; env -i $(GOLANG_BUILD_ENV) ./make.bash
endef

#
# Install Go by simply copying the source and the binary to the final
# destination
#
define HOST_GOLANG_INSTALL_CMDS
	cp -a $(HOST_GOLANG_SRCDIR) $(GOLANG_GOROOT_FINAL)
	ln -fs $(GOLANG_GOROOT_FINAL)/bin/go $(GO_HOST_BINARY)
endef

$(eval $(host-generic-package))
