################################################################################
#
# embd
#
################################################################################

EMBD_LICENSE = MIT
EMBD_VERSION = bfcd1345fe4e3d17ca82475c0c2f3d53120f87a9
EMBD_SITE = $(call github,kidoman,embd,$(EMBD_VERSION))
EMBD_EXTRACT_DIR = $(@D)/src/github.com/kidoman/embd
EMBD_BUILD_PACKAGES = github.com/kidoman/embd/embd

EMBD_DEPS += $(call fetch-golang-package, github.com/codegangsta/cli, cf1f63a7274872768d4037305d572b70b1199397)
EMBD_DEPS += $(call fetch-golang-package, github.com/golang/glog, 23def4e6c14b4da8ac2ed8007337bc5eb5007998)

$(eval $(golang-package))
