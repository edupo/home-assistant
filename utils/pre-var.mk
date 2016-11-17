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
  sys.check     = dpkg --status $(1) $(MUTE_STDERR) | grep installed
  sys.check2    = which $(1)
  sys.install   = sudo apt-get install $(if $(UNATTENDED),-y) $(1)
  sys.uninstall = sudo apt-get remove $(if $(UNATTENDED),-y) $(1)
  pip.install   = sudo pip install $(1)
else
  $(error Your package management is not compatible with these makefiles.) 
endif

__PRE_VAR_MK := 1
