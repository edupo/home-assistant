#!/usr/bin/make
# This script helps you to create a complete devpi cache server for pip.
# Is possible to deploy internal packages to the cache server so that we can
# install them as regular pip packages.
#
# http://doc.devpi.net/latest/index.html

include scripts/paths.mk
include scripts/utils/utils.mk

export DEVPI_USER=devpi
export DEVPI_GROUP=devpi
export DEVPI_HOME=/opt/devpi

DEVPI_PROFILE=$(DEVPI_HOME)/.profile

DEVPI_SERVICE_FILE=devpi.service
DEVPI_SERVICE_FILE_IN=../systemd.service/$(DEVPI_SERVICE_FILE).in
DEVPI_SERVICE_FILE_OUT=$(SYSTEMD_SYSTEM_DIR)/$(DEVPI_SERVICE_FILE)

setup: $(SYSTEMD_SYSTEM_DIR) | systemctl.check envsubst.check useradd.check
	# Creating home folder
	mkdir -p $(DEVPI_HOME)
	# Adding user
	useradd -d $(DEVPI_HOME) -g $(DEVPI_GROUP) $(DEVPI_USER)
	# Home permissions
	chown $(DEVPI_USER):$(DEVPI_GROUP) $(DEVPI_HOME)
	chmod 750 $(DEVPI_HOME)
	# Systemd file
	envsubst <$(DEVPI_SERVICE_FILE_IN) >$(DEVPI_SERVICE_FILE_OUT)
	chmod 664 $(SYSTEMD_SYSTEM_DIR)/$(DEVPI_SERVICE_FILE)
	# Enabling the service
	systemctl enable $(DEVPI_SERVICE_FILE)
