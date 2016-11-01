#!/usr/bin/make

PLUGINS += Valloric/YouCompleteMe
SECTIONS += YCM_SECTION

define YCM_SECTION
" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endef
