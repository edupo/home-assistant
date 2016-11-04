#!/usr/bin/make
#
# This file defines some basic format conventions.
# It also enables some shell specific features through definition
# of formatting variables.
#
# Created on: 04.11.16

HOST_OS ?= $(shell uname -s | sed 's/MINGW32_//;s/CYGWIN_//')

# Macros
info :=  echo 
time := `date +"%H:%M:%S"`
TAB_STDOUT := | sed 's/^/\t/'
MUTE_STDOUT := 1> /dev/null
MUTE_ALLOUT := &> /dev/null

# Color definitions
ifneq "$(HOST_OS)" "NT-6.1"
  ifneq "$(shell which tput)" ""
    ifeq "8" "$(shell tput colors 2>/dev/null)"
      bb = $(shell tput bold)
      ul = $(shell tput smul)
      hl = $(shell tput smso)
      no = $(shell tput sgr0)
      dm = $(shell tput dim)
      bk = $(shell tput setaf 0)
      rd = $(shell tput setaf 1)
      gr = $(shell tput setaf 2)
      ye = $(shell tput setaf 3)
      bl = $(shell tput setaf 4)
      ma = $(shell tput setaf 5)
      cy = $(shell tput setaf 6)
      wh = $(shell tput setaf 7)
    endif
  endif
endif

MSG=echo -e

# Message formatting
msg_g = "[$(gr)$(1)$(no)] $(time) : $(2)"
msg_r = "[$(rd)$(1)$(no)] $(time) : $(2)"
msg_y = "[$(ye)$(1)$(no)] $(time) : $(2)"
msg_b = "[$(bl)$(1)$(no)] $(time) : $(2)"

# Output formatting
tab_out = $(1) $(TAB_STDOUT) 
mute_out = $(1) $(MUTE_STDOUT)

FORMAT_MK:=1
