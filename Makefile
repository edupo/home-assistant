#!/usr/bin/make
#
# Root makefile. Goals are extracted from the command and the appliead to the
# modules listed by the user.
#
# Created on: 04.11.16

include ./utils/pre-var.mk

### Variables ###
export HOME?=$(shell echo $HOME)

# Valid main goals depends on the availability of some tools.
# Like to perform install you may depend on a package manager.
_VALID_MAIN_GOALS = config clean clean.all
ifndef _NO_PKGMAN
_VALID_MAIN_GOALS += install uninstall
endif

_MAIN_GOALS := $(or $(filter $(_VALID_MAIN_GOALS),$(MAKECMDGOALS)),"config")
MAKECMDGOALS := $(filter-out $(_VALID_MAIN_GOALS),$(MAKECMDGOALS))

_MODULES = git bash vim tmux

### General rules ###
.PHONY: all $(_MODULES)

default:
	@$(MAKE) install all 
	@$(MAKE) config all 

$(_MODULES):
	@$(MAKE) --no-print-directory --directory=$@ $(_MAIN_GOALS)
	@$(ECHO) $(call msg_ok,Done '$(_MAIN_GOALS)' for '$@')

all: $(_MODULES)
	@$(ECHO) $(call msg_ok,All done.)

.PHONY: $(_VALID_MAIN_GOALS)
$(_VALID_MAIN_GOALS): ;
