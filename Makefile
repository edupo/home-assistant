
export HOME?=$(shell echo $HOME)

all:
	@echo $(HOME)
	@$(MAKE) --no-print-directory --directory vim all

