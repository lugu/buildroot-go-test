################################################################################
#
# rtop
#
################################################################################

RTOP_LICENSE = MIT
RTOP_VERSION = release_1.0
RTOP_SITE = $(call github,rapidloop,rtop,$(RTOP_VERSION))
RTOP_EXTRACT_DIR = $(@D)/src/github.com/rapidloop/rtop
RTOP_BUILD_PACKAGES = github.com/rapidloop/rtop

RTOP_DEPS += $(call fetch-golang-package, golang.org/x/crypto/curve25519, 1f22c0103821b9390939b6776727195525381532)
RTOP_DEPS += $(call fetch-golang-package, golang.org/x/crypto/ssh, 1f22c0103821b9390939b6776727195525381532)

$(eval $(golang-package))
