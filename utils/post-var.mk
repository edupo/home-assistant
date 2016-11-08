#!/usr/bin/make
#
# This file should be included at the end of your current file.
# Used like that will generate many general rules in an automated way.
# Keep reading to know how.
#
# Created on: 07.11.16

# Generation of lists used by some standard targets.
FILES = $(foreach v,$(filter _%_FILE,$(.VARIABLES)),$(value $(v)))
$(info $(FILES))
DIRS += $(foreach d,$(filter _%_DIR,$(.VARIABLES)),$(value $(v)))
DIRS += $(dir $(FILES))
DIRS := $(sort $(DIRS)) 
$(info $(DIRS))

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

# Implicit terminal rule for .in files. This rule is only executed if the target
# file has a .in file inside the Makefile directory.
# Ex: '~/.basrc' will only be substituted if '.bashrc.in' exist.
%:: $$(notdir $$@).in Makefile | $$(dir $$@)
	$(recipe.envsubst)

$(DIRS):
	mkdir -p $@

.PHONY: config clean install uninstall

config: $(DIRS) $(FILES)

clean:
	rm $(FILES)

install: $(addsuffix .install,$(PACKAGES))

uninstall: $(addsuffix .uninstall,$(PACKAGES))
