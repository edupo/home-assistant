#!/usr/bin/make

include ../utils/utils.mk

### Variables ###

# File naming
RC_FILE = .vimrc
OUT_FILE = $(HOME)/$(RC_FILE)
IN_FILE = vimrc.in

# Vim paths
VIM_USER_PATH = $(HOME)/.vim
VIM_BUNDLE_PATH = $(VIM_USER_PATH)/bundle

# Components are the files which will generate the final rc file.
# Note Vundle is always added the last.
COMPONENTS = ultisnips.mk python.mk ycm.mk
COMPONENTS += vundle.mk

include $(COMPONENTS)

# vimrc body generation
export BODY = $(foreach section,$(SECTIONS),"--- $(section) ---"$(NL)$(NL)$($(section))$(NL)$(NL))
VAR_LIST += BODY

### General rules ###

.PHONY: config install 
config: $(OUT_FILE)

install: %.install
	@echo "vim (hopefully) installed."

### Specific rules ###

$(OUT_FILE): $(IN_FILE) Makefile $(COMPONENTS) 
	$(envsubst)

vim.install:
	@if [ -z `which vim` ]; then \
	  if [ ! -z `which apt-get` ]; then \
	    sudo apt-get install vim; \
	  fi \
	else 
	  echo "vim already installed";\
	fi
