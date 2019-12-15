#!/usr/bin/make
#
# Configure the shell
#
# Created on 15.12.2019

export FILE_SCRIPT_PROMPT          := $(abspath bash/prompt.sh)
export FILE_SCRIPT_GIT             := $(abspath bash/git.sh)
export FILE_SCRIPT_FILESEARCH      := $(abspath file_search.sh) 
ENVSUBST_VAR += FILE_SCRIPT_PROMPT FILE_SCRIPT_GIT FILE_SCRIPT_FILESEARCH
SHELL_FORMAT = $(ENVSUBST_VAR:%=$${%})

.PHONY: config install clean

config:
	@echo "-- Configuring bash"
	envsubst '$(SHELL_FORMAT)' <.bash_aliases.in >.bash_aliases
	envsubst '$(SHELL_FORMAT)' <.bashrc.in >.bashrc
	install -m 600 .bash_aliases $(HOME)
	install -m 700 .bashrc $(HOME)

install:
	@echo "-- Installing bash requisites"
	sudo apt install gettext

clean:
	rm .bash_aliases .bashrc
	

