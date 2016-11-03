
export HOME?=$(shell echo $HOME)

ALL = bash vim git tmux

all: $(ALL)
	@echo "All done."

.PHONY: $(ALL)
$(ALL):
	@echo "Doing '$@'"
	@$(MAKE) --no-print-directory --directory $@ all
