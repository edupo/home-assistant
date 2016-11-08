#!/usr/bin/make
#
# Include this file BEFORE you start assigning variables.
# It gives some utilities.
#
# Created on: 08.11.16

# Second expansion required for some implicit rules. See further.
.SECONDEXPANSION:

# Some usefull paths independent from the caller.
export UTILS_DIR  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export ROOT_DIR   := $(realpath $(dir $(UTILS_DIR)))

# Formatting utils
include $(UTILS_DIR)/format.mk

# Global variable initialization (as simple variables)
PACKAGES          :=
FILES             :=
DIRS              :=

# Definition of New Line character for code generation.
define NL


endef

# Got it from the gmake manual itself ;)
pathsearch = $(firstword $(wildcard $(addsuffix /$(1), $(subst :, ,$(PATH)))))

# Automatic installation stuff 
# TODO: It could be a difference in package naming between different os pkg
# managers. Rigth now only 'apt-get' is supported with 'Debian' packages.
# Deal with it.
ifneq ($(call pathsearch,apt-get),)
  _SYS_PM_INSTALL = sudo apt-get install
  _SYS_PM_UNINSTALL = sudo apt-get remove
  sys.install = $(_SYS_PM_INSTALL) $(if $(UNATTENDED),-y) $(1)
  sys.uninstall = $(_SYS_PM_UNINSTALL) $(if $(UNATTENDED),-y) $(1)
else
  $(error Your package management is not compatible with these makefiles.) 
endif

__PRE_VAR_MK := 1
