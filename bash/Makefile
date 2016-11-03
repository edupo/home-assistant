#!/usr/bin/make
include ../utils/utils.mk

ALIAS_FILE = $(HOME)/.bash_aliases
export GIT_SCRIPT_FILE=$(abspath git.sh)
export FILESEARCH_SCRIPT_FILE=$(abspath filesearch.sh)

VAR_LIST = GIT_SCRIPT_FILE FILESEARCH_SCRIPT_FILE

# General rules
.PHONY: all clean

all: $(ALIAS_FILE)
	@echo "Made 'all' for 'bash'"

clean:
	rm $(ALIAS_FILE)

# Specific rules

$(ALIAS_FILE): bash_aliases
	$(envsubst)
