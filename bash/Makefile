#!/usr/bin/make
#
# Assistence makefile for bash
#
# Created on: 04.11.16

include ../utils/utils.mk
include $(UTILS_PATH)/format.mk

### Variables ###
ALIAS_FILE = $(HOME)/.bash_aliases
BASHRC_FILE = $(HOME)/.bashrc
FILE_LIST = $(ALIAS_FILE) $(BASHRC_FILE)
export PROMPT_SCRIPT_FILE = $(abspath prompt.sh) 
export GIT_SCRIPT_FILE=$(abspath git.sh)
export FILESEARCH_SCRIPT_FILE=$(abspath file_search.sh)

VAR_LIST = GIT_SCRIPT_FILE FILESEARCH_SCRIPT_FILE PROMPT_SCRIPT_FILE

### General rules ###
.PHONY: config install clean
config: $(FILE_LIST)

install: ;

uninstall: ;

clean:
	rm $(FILE_LIST)
