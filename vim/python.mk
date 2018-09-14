#!/usr/bin/make
#
# Python language configuration
#
# Created on: 08.11.16

PLUGINS    += tmhedberg/SimpylFold vim-scripts/indentpython.vim nvie/vim-flake8\
	      tell-k/vim-autopep8
SECTIONS   += PYTHON_SECTION

define PYTHON_SECTION
" Python
let g:ycm_python_binary_path = 'python3'
au FileType python set autoindent
au BufRead,BufNewFile *.py,*.pyw
		\ set tabstop=4 |
		\ set shiftwidth=4 | 
		\ set expandtab |
		\ match BadWhitespace /^\t\+/ |
		\ match BadWhitespace /\s\+$$/ |
		\ set textwidth=100 |
		\ set fileformat=unix |
au BufRead,BufNewFile *.py 
		\ set softtabstop=4
let python_highlight_all=1
endef
