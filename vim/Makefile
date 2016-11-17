#!/usr/bin/make
#
# Vim main assistant makefile.
# As configuration for vim is not tribial (depends on how much do you like it)
# The assistant makefiles are splitted in components. Every component adds 
# information 
#
# Created on: 08.11.16
.SECONDEXPANSION:

include ../utils/pre-var.mk
### Variables ###

# Directories
_VIM_USER_DIR   := $(HOME)/.vim
_VIM_BUNDLE_DIR := $(_VIM_USER_DIR)/bundle
_VIM_FTPLUG_DIR := $(HOME)/.vim/ftplugin

# File
_VIMRC_FILE     := $(HOME)/.vimrc
_HELP_FILE      := $(_VIM_FTPLUG_DIR)/help.vim

# Components are the files which will generate the final rc file.
# Note Vundle is always added the last.
COMPONENTS 	:= ultisnips.mk python.mk ycm.mk
COMPONENTS 	+= vundle.mk

PLUGINS         := scrooloose/nerdcommenter

include $(COMPONENTS)
PACKAGES := vim $(PACKAGES)

include $(UTILS_DIR)/post-var.mk

# vimrc body generation
export BODY = $(foreach section,$(SECTIONS)\
	,"--- $(section) ---"$(NL)$(NL)$($(section))$(NL)$(NL))
VAR_LIST += BODY

### Specific rules ###
$(_VIMRC_FILE): $(COMPONENTS) 
