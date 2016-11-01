#!/usr/bin/make

# Small canned recipes as utils

define envsubst =
envsubst '$(addsuffix },$(addprefix $${,$(VAR_LIST)))' <$< >$@
endef
