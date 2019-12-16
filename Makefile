TARGETS=bash git tmux python vim 

.PHONY: all $(TARGETS)


all: $(TARGETS)
	@echo "-- Finished"

$(TARGETS):
	$(MAKE) -C $@
