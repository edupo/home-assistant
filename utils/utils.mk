#!/usr/bin/make

# Definition of New Line character for code generation.
define NL


endef

# Small canned recipes as utils
define envsubst =
envsubst '$(addsuffix },$(addprefix $${,$(VAR_LIST)))' <$< >$@
endef
