#!/usr/bin/make
#
# Assistence makefile for bash
#
# Created on: 04.11.16

include ../utils/utils.mk
include $(UTILS_PATH)/format.mk

### Variables ###
ALIAS_FILE = $(HOME)/.bash_aliases
export GIT_SCRIPT_FILE=$(abspath git.sh)
export FILESEARCH_SCRIPT_FILE=$(abspath file_search.sh)

VAR_LIST = GIT_SCRIPT_FILE FILESEARCH_SCRIPT_FILE

### General rules ###
.PHONY: config install clean
config: $(ALIAS_FILE)

install: ;

uninstall: ;

clean:
	rm $(ALIAS_FILE)

### Specific rules ###
$(ALIAS_FILE): bash_aliases
	$(envsubst)
