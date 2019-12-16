#!/usr/bin/make

################################################################################
#                                    UTILS                                     #
################################################################################

# Color definitions
ifneq "$(shell which tput)" ""
  ifeq "8" "$(shell tput colors 2>/dev/null)"
    no = $(shell tput sgr0)
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
export FILE_SCRIPT_FILESEARCH := $(abspath bash/file_search.sh) 
SHELL_FILES                   := $(HOME)/.bash_aliases $(HOME)/.bashrc
SHELL_VARS                    := FILE_SCRIPT_PROMPT FILE_SCRIPT_GIT \
                                 FILE_SCRIPT_FILESEARCH
CLEAN_FILES                   += $(SHELL_FILES)

# Tmux
TMUX_FILES                    := $(HOME)/.tmux.conf

# Vim
export SNIPS_PARENT_DIR := $(shell pwd)
VIM_FILES 			    := $(HOME)/.vimrc 
VIM_VARS                := SNIPS_PARENT_DIR

# Global
CONFIG_FILES   := $(SHELL_FILES) $(VIM_FILES) $(TMUX_FILES)
ENVSUBST_FILES := $(foreach f, $(CONFIG_FILES), $(notdir $(f)))
ENVSUBST_VARS  := $(SHELL_VARS) $(VIM_VARS)
CLEAN_FILES    := $(ENVSUBST_FILES)

################################################################################
#                                   TARGETS                                    #
################################################################################

.PHONY: config clean

config: bash.config git.config tmux.config vim.config
	@echo "$(gr)-- Nothing else to configure.$(no)"

info:
	@echo "$(gr)Config files:$(no) $(CONFIG_FILES)"
	@echo "$(gr)Envsubst files:$(no) $(ENVSUBST_FILES)"

install: .installed
	@echo "$(gr)-- Nothing else to install.$(no)"

clean:
	rm $(CLEAN_FILES)

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
	@echo "$(gr)-- Installed requisites$(no)"

bash.config: .installed $(SHELL_FILES)
	@echo "$(gr)-- Configured shell$(no)"

git.config: .installed
	git config --global core.excludesfile '$(realpath gitignore)'
	git config --global credential.helper cache
	git config --global credential.helper 'cache --timeout=3600'
	$(call git.config,user.name,complete user name)
	$(call git.config,user.email,user email)
	$(call git.config,user.github,github user)
	$(call git.config,user.company,company name)
	$(call git.config,user.baseurl,url of your main git repository)
	@echo "$(gr)-- Configured git$(no)"

tmux.config: .installed $(TMUX_FILES)
	@echo "$(gr)-- Configured tmux$(no)"

vim.config: .installed $(VIM_FILES) $(HOME)/.vim/autoload/plug.vim
	@echo "$(gr)-- Configured vim$(no)"

$(HOME)/.vim/autoload/plug.vim: .installed
	curl -fLo $@ --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.SECONDEXPANSION:

$(ENVSUBST_FILES): $$@.in Makefile
	envsubst '$(ENVSUBST_VARS:%=$${%})' <$< >$(notdir $@)

$(CONFIG_FILES): $$(notdir $$@)
	install -m 600 $< $@

