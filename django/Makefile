#!/usr/bin/make
#
# Django is a high-level Python Web framework that encourages rapid development
# and clean, pragmatic design.
#
# Created on: 07.11.16

include ../utils/pre-var.mk

### Variables ###
_ENVS_DIR      := $(HOME)/venvs
_P3_ENV_DIR    := $(_ENVS_DIR)/p3

include ../utils/post-var.mk

### General rules ###
install: $(HOME)/p3.activate 

$(HOME)/p3.activate: | virtualenv.pipinstall $(_P3_ENV_DIR)
	virtualenv --python=python3 $(_P3_ENV_DIR)
	$(ECHO) $(call msg_ok,Python3 virtual environment '$(_P3_ENV_DIR)'); \
	. $(_P3_ENV_DIR)/bin/activate; pip install Django
	$(ECHO) $(call msg_ok,Installed 'django' in '$(_P3_ENV_DIR)'); \
	ln -s $(_P3_ENV_DIR)/bin/activate $(HOME)/p3.activate
	$(ECHO) $(call msg_ok,Installed '$(HOME)/p3.activate'); \

virtualenv.pipinstall: | $(_ENVS_DIR)
