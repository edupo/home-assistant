#!/usr/bin/make

include ../utils/utils.mk

RC_FILE = .vimrc
OUT_FILE = $(HOME)/$(RC_FILE)
IN_FILE = $(RC_FILE).in

# Components are the files which will generate the final rc file.
COMPONENTS = ultisnips.mk python.mk ycm.mk
# Do not reorder!
# Vundle should be always the last plugin.
COMPONENTS += vundle.mk

include $(COMPONENTS)

export BODY = $(foreach section,$(SECTIONS),$($(section))$(NL)$(NL))

VAR_LIST += BODY

all: $(OUT_FILE)

$(HOME)/.vimrc: .vimrc.in Makefile $(COMPONENTS) 
	$(envsubst)
