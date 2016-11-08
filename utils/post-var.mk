#!/usr/bin/make
#
# Include this file AFTER your variable assignment block.
# Used like that will generate many general rules in an automated way.
# Keep reading to know how.
#
# Created on: 07.11.16

# Check for required inclusions.
ifndef __PRE_VAR_MK
  $(error 'pre-var.mk' is not included in your makefile.)
endif

# Generation of lists used by some standard targets.
FILES = $(foreach v,$(filter _%_FILE,$(.VARIABLES)),$(value $(v)))
DIRS += $(foreach d,$(filter _%_DIR,$(.VARIABLES)),$(value $(v)))
DIRS += $(dir $(FILES))
DIRS := $(sort $(DIRS)) 

%.install:
	@if [ ! -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_g,INSTAL,Installing '$(basename $@)'); \
	  $(call sys.install,$(basename $@)); \
	else \
	  $(ECHO) $(call msg_g,INSTAL,'$(basename $@)' is already installed); \
	fi

%.uninstall:
	@if [ -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_g,UINST ,Uninstalling '$(basename $@)'); \
	  $(call sys.uninstall,$(basename $@)); \
	else \
	  $(ECHO) $(call msg_g,UINST ,'$(basename $@)' is not installed); \
	fi

%.check:
	@if [ ! -e "$(call pathsearch,$(basename $@))" ]; then \
	  $(ECHO) $(call msg_r,ERROR ,'$(basename $@)' is not installed); \
	else \
	  $(ECHO) $(call msg_g,CHECK ,'$(basename $@)' found); \
	fi

# Implicit terminal rule for .in files. This rule is only executed if the target
# file has a .in file inside the Makefile directory.
# Ex: '~/.basrc' will only be substituted if '.bashrc.in' exist.
%:: $$(notdir $$@).in Makefile | $$(dir $$@)
	@$(ECHO) $(call msg_g,CONFIG,'$<' -> '$@')
	@envsubst '$(addsuffix },$(addprefix $${,$(VAR_LIST)))' <$< >$@

# Directory creation rule
$(DIRS):
	mkdir -p $@

# Main targets rules
.PHONY: config clean install uninstall

config: $(addsuffix .check, $(PACKAGES)) $(DIRS) $(FILES)

clean:
	@$(ECHO) "$(rd)This action will remove files: \
	  $(addprefix \n\t,$(FILES))"
	@read -r -p "Are you sure?$(no) " REPLY; \
	if [ "$$REPLY" = "Y" ] || [ "$$REPLY" = "y" ]; then \
	  rm $(FILES); \
	fi

clean.all:
	@$(ECHO) "$(rd)This action will remove next directories: \
	  $(addprefix \n\t,$(DIRS))"
	@read -r -p "Are you sure?$(no) " REPLY; \
	if [ "$$REPLY" = "Y" ] || [ "$$REPLY" = "y" ]; then \
	  rm -fr $(DIRS); \
	fi

install: $(addsuffix .install,$(PACKAGES))

uninstall: $(addsuffix .uninstall,$(PACKAGES))

info:
	@$(ECHO) "ROOT_DIRECTORY: $(ROOT_DIR)"
	@$(ECHO) "UTILITIES DIRECTORIES: $(UTILS_DIR)"
	@$(ECHO) "DIRECTORIES: \
		$(addprefix \n\t,$(DIRS))"
	@$(ECHO) "FILES: \
		$(addprefix \n\t,$(FILES))"

