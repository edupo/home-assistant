#!/usr/bin/make
#
# Vundle component for vim assistant makefiles
#
# Created on: 08.11.16

# To avoid 'cheating' vundle uses the same mechanism than for other plugins.
# But you want Vundle to be loaded first. Believe me.
PLUGINS       := gmarik/Vundle.vim ${PLUGINS}
SECTIONS      := VUNDLE_SECTION ${SECTIONS}
PACKAGES      := vundle $(PACKAGES)
_VUNDLE_DIR   := $(_VIM_BUNDLE_DIR)/Vundle.vim

define VUNDLE_SECTION
" Vundle is a plugin manager for vim.
" This is it's initialization section.

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

$(foreach plugin,$(PLUGINS),Plugin '$(plugin)'$(NL))

" To be tested
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()
endef

vundle.install: | $(_VIM_BUNDLE_DIR)
	@$(ECHO) $(call msg_g,INSTAL,Installing vundle for vim)
	@if [ ! -d "$(_VUNDLE_DIR)" ]; then \
	  git clone https://github.com/VundleVim/Vundle.vim.git \
		$(_VIM_BUNDLE_DIR)/Vundle.vim; \
	else \
	  cd $(_VUNDLE_DIR); \
	  git pull; \
	fi
	vim +PluginInstall +qall;
