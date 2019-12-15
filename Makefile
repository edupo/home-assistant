TARGETS=all bash git tmux vim

.PHONY: $(TARGETS)


all: $(TARGETS)
	@echo "-- Finished"

$(TARGETS):
	$(MAKE) -C $@
