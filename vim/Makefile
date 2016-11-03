#!/usr/bin/make

include ../utils/utils.mk

# File naming
RC_FILE = .vimrc
OUT_FILE = $(HOME)/$(RC_FILE)
IN_FILE = vimrc.in

# Components are the files which will generate the final rc file.
# Note Vundle is always added the last.
COMPONENTS = ultisnips.mk python.mk ycm.mk
COMPONENTS += vundle.mk

# Include the component files.
include $(COMPONENTS)

# Creation of the body section.
export BODY = $(foreach section,$(SECTIONS),"--- $(section) ---"$(NL)$(NL)$($(section))$(NL)$(NL))

# Rules
all: $(OUT_FILE)

VAR_LIST += BODY
$(OUT_FILE): $(IN_FILE) Makefile $(COMPONENTS) 
	$(envsubst)

.PHONY: setup
setup:
	@if [ -z `which vim` ]; then \
	  if [ ! -z `which apt-get` ]; then \
	    sudo apt-get install vim; \
	  fi \
	else \
	  echo "vim already installed";\
	fi
