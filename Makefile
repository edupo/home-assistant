#!/usr/bin/make
#
# Root makefile. Goals are extracted from the command and the appliead to the
# modules listed by the user.
#
# Created on: 04.11.16

include ./utils/pre-var.mk

### Variables ###
export HOME?=$(shell echo $HOME)

_VALID_MAIN_GOALS = install config clean uninstall clean.all
_MAIN_GOALS := $(or $(filter $(_VALID_MAIN_GOALS),$(MAKECMDGOALS)),"config")
$(info $(_MAIN_GOALS))
MAKECMDGOALS := $(filter-out $(_VALID_MAIN_GOALS),$(MAKECMDGOALS))
$(info $(MAKECMDGOALS))

_MODULES = git bash vim tmux django

### General rules ###
.PHONY: all $(_MODULES)
$(_MODULES):
	@$(ECHO) $(call msg_g,ASSIST,Doing '$(_MAIN_GOALS)' for '$@')
	@$(MAKE) --no-print-directory --directory=$@ $(_MAIN_GOALS)

all: $(_MODULES)
	@$(ECHO) $(call msg_g,ASSIST,All done.)

.PHONY: $(_VALID_MAIN_GOALS)
$(_VALID_MAIN_GOALS): ;
