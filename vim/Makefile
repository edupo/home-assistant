#!/usr/bin/make
#
# Created on: 08.11.16

export SNIPS_PARENT_DIR = $(shell pwd)
ENVSUBST_VAR += SNIPS_PARENT_DIR
SHELL_FORMAT = $(ENVSUBST_VAR:%=$${%})

.PHONY: config install clean

config: install $(HOME)/.vim/autoload/plug.vim
	@echo "-- Configuring vim"
	envsubst '$(SHELL_FORMAT)' <.vimrc.in >.vimrc
	install -m 600 .vimrc $(HOME)

install:
	@echo "-- Install vim requirements"
	sudo apt install vim curl

$(HOME)/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

