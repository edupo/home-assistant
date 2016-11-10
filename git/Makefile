#!/usr/bin/make
#
# Git home assistance makefile
#
# Created on: 04.11.16

include ../utils/pre-var.mk

### Variables ###
_GITCONFIG_FILE := $(HOME)/.gitconfig
GCFG            := git config --global

include ../utils/post-var.mk

define git.config
@if [ ! "`$(GCFG) $(1)`" ]; then \
  read -p "Enter $(2): " _T; \
  $(GCFG) $(1) "$$_T"; \
fi
endef

### Rules ###
$(_GITCONFIG_FILE): Makefile
	@$(ECHO) $(call msg_g,CONFIG,Configuring 'git')
	$(GCFG) core.excludesfile '$(realpath gitignore)'
	$(GCFG) push.default simple
	$(call git.config,user.name,complete user name)
	$(call git.config,user.email,user email)
	$(call git.config,user.github,github user)
	$(call git.config,user.company,company name)
