#!/usr/bin/make
#
# Git home assistance makefile
#
# Created on: 04.11.16

include ../utils/utils.mk

### Variables ###
GCFG = git config --global

define git.config
@if [ ! "`$(GCFG) $(1)`" ]; then \
  read -p "Enter $(2): " _T; \
  $(GCFG) $(1) "$$_T"; \
fi
endef

### Rules ###

config:
	@$(ECHO) $(call msg_g,CONFIG,Configuring 'git')
	$(GCFG) core.excludesfile '$(realpath gitignore)'
	$(GCFG) push.default simple
	$(call git.config,user.name,complete user name)
	$(call git.config,user.email,user email)
	$(call git.config,user.company,company name)

install: git.install

clean:
	rm $(HOME)/.gitconfig

uninstall: git.uninstall
