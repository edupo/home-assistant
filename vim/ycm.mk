#!/usr/bin/make
#
# Ycm component for vim assistant makefiles
#
# Created on: 08.11.16

PLUGINS     += Valloric/YouCompleteMe
SECTIONS    += YCM_SECTION
PACKAGES    += cmake ycm

define YCM_SECTION
" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endef

ycm.install:
	$(_VIM_BUNDLE_DIR)/YouCompleteMe/install.py --clang-completer
