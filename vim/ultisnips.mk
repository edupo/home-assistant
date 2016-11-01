#!/usr/bin/make
# Snippets plugin to be very happy and improve your productivity.

# These are the plugins required to make this work.
PLUGINS += SirVer/ultisnips honza/vim-snippets
# This is the section it will be added to the final rc file.
SECTIONS += ULTISNIPS_SECTION

# Variable definition
SNIPS_PARENT_FOLDER=$(shell pwd)

define ULTISNIPS_SECTION
" Ultisnips
set rtp+=${SNIPS_PARENT_FOLDER}
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
endef
