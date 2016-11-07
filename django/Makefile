#!/usr/bin/make
#
# Django is a high-level Python Web framework that encourages rapid development
# and clean, pragmatic design.
#
# Created on: 07.11.16

include ../utils/utils.mk
include $(UTILS_PATH)/format.mk

### Variables ###
ENVS_DIR = $(HOME)/venvs
P3_ENV_DIR = $(ENVS_DIR)/p3
DIR_LIST = $(ENVS_DIR) $(P3_ENV_DIR)

### General rules ###
install: virtualenv.install | $(P3_ENV_DIR)
	virtualenv --python=python3 $(P3_ENV_DIR)
	. $(P3_ENV_DIR)/bin/activate; pip install Django

virtualenv.install: python-pip.install | $(ENVS_DIR)
	sudo pip install virtualenv

$(DIR_LIST):
	mkdir -p $@
