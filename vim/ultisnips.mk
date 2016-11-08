#!/usr/bin/make
#
# Snippets plugin to be very happy and improve your productivity.
#
# Created on: 08.11.16

PLUGINS    += SirVer/ultisnips honza/vim-snippets
SECTIONS   += ULTISNIPS_SECTION
SNIPS_PARENT_DIR=$(shell pwd)

define ULTISNIPS_SECTION
" Ultisnips needs rtp directed to the paret of the snippets folder.
set rtp+=$(SNIPS_PARENT_DIR)
" Snippets directory
let g:UltiSnipsSnippetsDir="$(SNIPS_PARENT_DIR)/UltiSnips"

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" :UltiSnipsEdit command splits current window
let g:UltiSnipsEditSplit="vertical"
endef
