#
# Copyright (C) 2017 OpenWrt Project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

TOPDIR:=${CURDIR}
include $(TOPDIR)/rules.mk

RELEASE:=$(if $(RELEASE),$(RELEASE),"reboot")

VERSION?=2.27

FEEDS_REPO:="http://download.gl-inet.com/lede/packages/$(VERSION)"
FEEDS_INSTALLED:=$(notdir $(wildcard $(TOPDIR)/package/feeds/*))
FEEDS_AVAILABLE:=$(sort $(FEEDS_INSTALLED) $(shell $(SCRIPT_DIR)/feeds list -n))
FEEDS_ENABLED:=$(foreach feed,$(FEEDS_AVAILABLE),$(if $(CONFIG_FEED_$(feed)),$(feed)))
FEEDS_DISABLED:=$(filter-out $(FEEDS_ENABLED),$(FEEDS_AVAILABLE))

define FeedSourcesAppend
( \
  echo "src/gz $(RELEASE)_core $(FEEDS_REPO)/$(ARCH_PACKAGES)/core"; \
  $(strip $(if $(CONFIG_PER_FEED_REPO), \
	$(foreach feed,base $(FEEDS_ENABLED),echo "src/gz $(RELEASE)_$(feed) $(FEEDS_REPO)/$(ARCH_PACKAGES)/$(feed)";) \
	$(if $(CONFIG_PER_FEED_REPO_ADD_DISABLED), \
		$(foreach feed,$(FEEDS_DISABLED),echo "$(if $(CONFIG_PER_FEED_REPO_ADD_COMMENTED),# )src/gz $(RELEASE)_$(feed) $(FEEDS_REPO)/$(ARCH_PACKAGES)/$(feed)";)))) \
) >> $(1)
endef

all:
	-rm -fr files
	$(INSTALL_DIR) files/etc
	$(INSTALL_DIR) files/etc/opkg

	@echo $(VERSION) > files/etc/glversion
	$(call FeedSourcesAppend,files/etc/opkg/distfeeds.conf)
