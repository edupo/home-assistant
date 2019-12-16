#!/usr/bin/make

################################################################################
#                                    UTILS                                     #
################################################################################

# Color definitions
ifneq "$(shell which tput)" ""
  ifeq "8" "$(shell tput colors 2>/dev/null)"
	rd = $(shell tput setaf 1)
	gr = $(shell tput setaf 2)
	ye = $(shell tput setaf 3)
  endif
endif

define git.config
@if [ ! "`git config --global $(1)`" ]; then \
  read -p "Enter $(2): " _T; \
  git config --global $(1) "$$_T"; \
fi
endef

################################################################################
#                                  VARIABLES                                   #
################################################################################

# Bash
export FILE_SCRIPT_PROMPT     := $(abspath bash/prompt.sh)
export FILE_SCRIPT_GIT        := $(abspath bash/git.sh)
export FILE_SCRIPT_FILESEARCH := $(abspath file_search.sh) 
SHELL_FILES                   := .bash_aliases .bashrc
SHELL_VARS                    := FILE_SCRIPT_PROMPT FILE_SCRIPT_GIT \
                                 FILE_SCRIPT_FILESEARCH

# Vim
export SNIPS_PARENT_DIR := $(shell pwd)
VIM_FILES 			    := .vimrc $(HOME)/.vim/autoload/plug.vim
VIM_VARS                := SNIPS_PARENT_DIR

# Global
ENVSUBST_FILES := $(SHELL_FILES) $(VIM_FILES)
ENVSUBST_VARS  := $(SHELL_VARS) $(VIM_VARS)

################################################################################
#                                   TARGETS                                    #
################################################################################

.PHONY: config install clean

config: bash.config git.config tmux.config vim.config
	@echo "$(gr)-- Configured all"

.installed: Makefile
	sudo apt install \
	  gettext \
	  git \
	  python3 python3-pip \
	  tmux xclip \
	  vim curl
	sudo pip3 install \
	  pylint autopep8 mccabe pycodestyle \
	  pydocstyle pyflakes yapf
	@touch .installed
	@echo "$(gr)-- Installed requisites"

clean:
	rm $(ENVSUBST_FILES)

bash.config: .install $(SHELL_FILES)
	install -m 600 .bash_aliases $(HOME)
	install -m 700 .bashrc $(HOME)
	@echo "$(gr)-- Configured shell"

git.config: .install
	git config --global core.excludesfile '$(realpath gitignore)'
	git config --global credential.helper cache
	git config --global credential.helper 'cache --timeout=3600'
	$(call git.config,user.name,complete user name)
	$(call git.config,user.email,user email)
	$(call git.config,user.github,github user)
	$(call git.config,user.company,company name)
	$(call git.config,user.baseurl,url of your main git repository)
	@echo "$(gr)-- Configured git"

tmux.config: .install
	install -m 600 .tmux.conf $(HOME)
	@echo "$(gr)-- Configured tmux"

vim.config: .install $(VIM_FILES)
	install -m 600 .vimrc $(HOME)
	@echo "$(gr)-- Configured vim"

$(HOME)/.vim/autoload/plug.vim: .install
	curl -fLo $@ --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.SECONDEXPANSION:
$(ENVSUBST_FILES): $$@.in Makefile
