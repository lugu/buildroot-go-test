################################################################################
#
# bolt
#
################################################################################

BOLT_LICENSE = MIT
BOLT_VERSION = v1.1.0
BOLT_SITE = $(call github,boltdb,bolt,$(BOLT_VERSION))
BOLT_EXTRACT_DIR = $(@D)/src/github.com/boltdb/bolt
BOLT_BUILD_PACKAGES = github.com/boltdb/bolt/cmd/bolt

$(eval $(golang-package))
