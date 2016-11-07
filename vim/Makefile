#!/usr/bin/make

include ../utils/utils.mk
include $(UTILS_PATH)/format.mk

### Variables ###

# Vim paths
VIM_USER_PATH = $(HOME)/.vim
VIM_BUNDLE_PATH = $(VIM_USER_PATH)/bundle
VIM_FTPLUG_PATH = $(VIM_USER_PATH)/ftplugin
# List of all paths
VIM_PATHS = $(VIM_USER_PATH) $(VIM_BUNDLE_PATH) $(VIM_FTPLUG_PATH)

# File naming
VIMRC_FILE = $(VIM_USER_PATH)/.vimrc
HELP_FILE = $(VIM_FTPLUG_PATH)/help.vim
CONFIG_TARGETS = $(VIMRC_FILE) $(HELP_FILE)

# Components are the files which will generate the final rc file.
# Note Vundle is always added the last.
COMPONENTS = ultisnips.mk python.mk ycm.mk
COMPONENTS += vundle.mk

include $(COMPONENTS)

# vimrc body generation
export BODY = $(foreach section,$(SECTIONS)\
	,"--- $(section) ---"$(NL)$(NL)$($(section))$(NL)$(NL))
VAR_LIST += BODY

### General rules ###

.PHONY: config install 
config: $(CONFIG_TARGETS) 

install: vim.install $(INSTALL_TARGETS)

### Specific rules ###

$(VIMRC_FILE): $(notdir $(VIMRC_FILE).in) Makefile $(COMPONENTS) | $(VIM_USER_PATH) 
	$(recipe.envsubst)

$(HELP_FILE): $(notdir $(HELP_FILE).in) | $(VIM_FTPLUG_PATH)
	cp $< $@

$(VIM_PATHS):
	mkdir -p $@
