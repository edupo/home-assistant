#!/usr/bin/make

include ../utils/utils.mk

# To avoid 'cheating' vundle uses the same mechanism than for other plugins.
# But you want Vundle to be loaded first. Believe me.
PLUGINS := gmarik/Vundle.vim ${PLUGINS}
SECTIONS := VUNDLE_SECTION ${SECTIONS}

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

INSTALL_TARGETS := vundle.install $(INSTALL_TARGETS)
vundle.install:
	@echo installing 'vundle'
	mkdir -p $(VIM_BUNDLE_PATH)
	git clone https://github.com/VundleVim/Vundle.vim.git \
		$(VIM_BUNDLE_PATH)/Vundle.vim
	vim +PluginInstall +qall
