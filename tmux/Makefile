#!/usr/bin/make
#
# Makefile for tmux assistance.
#
# Created on: 04.11.16

.PHONY: config install clean

config: install
	@echo "-- Configuring tmux"
	install -m 600 .tmux.conf $(HOME)

install:
	@echo "-- Installing tmux requisites"
	sudo apt install tmux xclip

clean:
	rm .tmux.conf

