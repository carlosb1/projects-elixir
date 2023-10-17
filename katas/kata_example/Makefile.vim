SHELL :=/bin/bash
.DEFAULT_GOAL:=test
.PHONY: test

test:
	mix test
