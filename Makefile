#!/usr/bin/make
#
# Root makefile. Goals are extracted from the command and the appliead to the
# modules listed by the user.
#
# Created on: 04.11.16

### Variables ###
export HOME?=$(shell echo $HOME)

_VALID_MAIN_GOALS = install config clean
_MAIN_GOALS = $(or $(filter $(_VALID_MAIN_GOALS),$(MAKECMDGOALS)),"all")

_MODULES = bash vim git tmux

### General rules ###
.PHONY: all $(_MODULES)
$(_MODULES):
	@echo "Doing '$(_MAIN_GOALS)' for '$@'."
	@$(MAKE) --no-print-directory --directory=$@ $(_MAIN_GOALS)

all: $(_MODULES)
	@echo "All done."
