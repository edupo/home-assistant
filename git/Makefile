#!/usr/bin/make
#
# Git home assistance makefile

define git.config
@if [ ! "`git config --global $(1)`" ]; then \
  read -p "Enter $(2): " _T; \
  git config --global $(1) "$$_T"; \
fi
endef

config: install
	@echo "-- Configuring git"
	git config --global core.excludesfile '$(realpath gitignore)'
	git config --global credential.helper cache
	git config --global credential.helper 'cache --timeout=3600'
	$(call git.config,user.name,complete user name)
	$(call git.config,user.email,user email)
	$(call git.config,user.github,github user)
	$(call git.config,user.company,company name)
	$(call git.config,user.baseurl,url of your main git repository)

install:
	sudo apt install git
