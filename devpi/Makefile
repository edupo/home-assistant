#!/usr/bin/make
# This script helps you to create a complete devpi cache server for pip.
# Is possible to deploy internal packages to the cache server so that we can
# install them as regular pip packages.
#
# http://doc.devpi.net/latest/index.html

include ../utils/pre-var.mk
include ../paths.mk

### Variables ###

DEVPI_USER=devpi
DEVPI_GROUP=devpi

_DEVPI_HOME_DIR=/opt/devpi

_DEVPI_SERVICE_FILE=$(SYSTEMD_SYSTEM_DIR)/devpi.service

include ../utils/post-var.mk

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
