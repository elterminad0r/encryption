.PHONY: all
all: $(shell echo P*.pas | sed -E "s/P([^.]*)\.pas/bin\/\1/g")

bin/%: P%.pas $(wildcard U*.pas)
	fpc -TLinux -o$@ $<
