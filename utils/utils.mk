#!/usr/bin/make

# Second expansion required for some implicit rules. See further.
.SECONDEXPANSION:

# Some usefull paths independent from the caller.
export UTILS_PATH = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export ROOT_PATH = $(realpath $(dir $(UTILS_PATH)))

include $(UTILS_PATH)/format.mk 

# Definition of New Line character for code generation.
define NL


endef

# Small canned recipes as utils
define recipe.envsubst
@$(ECHO) $(call msg_g,CONFIG,'$<' -> '$@')
@envsubst '$(addsuffix },$(addprefix $${,$(VAR_LIST)))' <$< >$@
endef

# Implicit terminal rule for .in files. This rule is only executed if the target
# file has a .in file inside the Makefile directory.
# Ex: '~/.basrc' will only be substituted if '.bashrc.in' exist.
%:: $$(notdir $$@).in Makefile
	$(recipe.envsubst)

# Got it from the gmake manual itself ;)
pathsearch = $(firstword $(wildcard $(addsuffix /$(1), $(subst :, ,$(PATH)))))

# Automatic installation stuff 
# TODO: It could be a difference in package naming between different os pkg
# managers. Rigth now only 'apt-get' is supported with 'Debian' packages.
# Deal with it.
ifneq ($(call pathsearch,apt-get),)
  _SYS_PM_INSTALL = sudo apt-get install
  _SYS_PM_UNINSTALL = sudo apt-get remove
  sys.install = $(_SYS_PM_INSTALL) $(if $(UNATTENDED),-y) $(1)
  sys.uninstall = $(_SYS_PM_UNINSTALL) $(if $(UNATTENDED),-y) $(1)
else
  $(error Your package management is not compatible with these makefiles.) 
endif

%.install:
	@if [ ! -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_g,INSTAL,Installing '$(basename $@)'); \
	  $(call sys.install,$(basename $@)); \
	fi

%.uninstall:
	@if [ -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_g,UINST ,Uninstalling '$(basename $@)'); \
	  $(call sys.uninstall,$(basename $@)); \
	fi

%.check:
	@if [ ! -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_r,INSTAL,'$(basename $@)' is not installed); \
	fi
