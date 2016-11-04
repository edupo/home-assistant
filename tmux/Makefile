#!/usr/bin/make
#
# Makefile for tmux assistance.
#
# Created on: 04.11.16

include ../utils/utils.mk

### Variables ###
OUT_FILE=$(HOME)/.tmux.conf
IN_FILE=tmux.conf

### Rules ###
.PHONY: config install
config: tmux.check xclip.check $(OUT_FILE)

install: tmux.install xclip.install

### Specific rules ###
$(OUT_FILE): $(IN_FILE) Makefile
	$(recipe.envsubst)
