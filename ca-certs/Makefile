#!/usr/bin/make
#
#
# http://doc.devpi.net/latest/index.html

include ../utils/pre-var.mk
include ../paths.mk
include ../utils/post-var.mk

ifneq ($(wildcard certs.pem),)
config: $(SYSTEM_CERTS_FILE)

$(SYSTEM_CERTS_FILE): certs.pem
	sudo cp $< $@
endif
