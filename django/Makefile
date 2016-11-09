#!/usr/bin/make
#
# Django is a high-level Python Web framework that encourages rapid development
# and clean, pragmatic design.
#
# Created on: 07.11.16

include ../utils/pre-var.mk

### Variables ###
_ENVS_DIR = $(HOME)/venvs
_P3_ENV_DIR = $(_ENVS_DIR)/p3

include ../utils/post-var.mk

### General rules ###
install: $(HOME)/p3.activate 

$(HOME)/p3.activate: | virtualenv.install $(_P3_ENV_DIR)
	virtualenv --python=python3 $(_P3_ENV_DIR)$(no)
	. $(_P3_ENV_DIR)/bin/activate; pip install Django
	ln -s $(_P3_ENV_DIR)/bin/activate $(HOME)/p3.activate

virtualenv.install: python-pip.install | $(_ENVS_DIR)
	sudo pip install virtualenv
