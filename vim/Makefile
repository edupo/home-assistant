#!/usr/bin/make

include ../utils/utils.mk

RC_FILE = .vimrc
OUT_FILE = $(HOME)/$(RC_FILE)
IN_FILE = $(RC_FILE).in
COMPONENTS = vundle.in

include $(COMPONENTS)

all: $(OUT_FILE)

$(HOME)/.vimrc: .vimrc.in Makefile $(COMPONENTS) 
	$(envsubst)
