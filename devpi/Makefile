#!/usr/bin/make
#
# This script helps you to create a complete devpi cache server for pip.
# Is possible to deploy internal packages to the cache server so that we can
# install them as regular pip packages.
#
# http://doc.devpi.net/latest/index.html

include ../utils/pre-var.mk
include ../paths.mk

### Variables ###

export DEVPI_USER=devpi
DEVPI_GROUP=devpi

export _DEVPI_HOME_DIR		:=/opt/devpi

_DEVPI_SERVICE_FILE	:=$(SYSTEMD_SYSTEM_DIR)/devpi.service

PACKAGES += devpi
# Macro specific for extra certificates file

ifneq ($(wildcard $(SYSTEM_CERTS_FILE)),)
define DEVPI_SERVICE_CERTS_MACRO
Environment=PIP_CERT=$(SYSTEM_CERTS_FILE)   
Environment=REQUESTS_CA_BUNDLE=$(SYSTEM_CERTS_FILE)
endef
export DEVPI_SERVICE_CERTS_MACRO
endif

VAR_LIST += DEVPI_USER DEVPI_GROUP _DEVPI_HOME_DIR DEVPI_SERVICE_CERTS_MACRO

include ../utils/post-var.mk

#$(_DEVPI_SERVICE_FILE): devpi.pipinstall 
$(_DEVPI_SERVICE_FILE): USER=$(DEVPI_USER)
$(_DEVPI_SERVICE_DILE): GROUP=$(DEVPI_GROUP)

$(_DEVPI_HOME_DIR): USER=$(DEVPI_USER)
$(_DEVPI_HOME_DIR): GROUP=$(DEVPI_GROUP)

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
