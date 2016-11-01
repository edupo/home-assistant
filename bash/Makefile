#!/usr/bin/make

include ../utils/utils.mk

ALIAS_FILE = $(HOME)/.bash_aliases

all: $(ALIAS_FILE)

export GIT_SCRIPT_FILE=$(abspath git.sh)
export FILESEARCH_SCRIPT_FILE=$(abspath filesearch.sh)

VAR_LIST = GIT_SCRIPT_FILE FILESEARCH_SCRIPT_FILE

$(ALIAS_FILE): bash_aliases
	$(envsubst)
