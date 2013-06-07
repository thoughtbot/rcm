PREFIX=/usr/local

install:
	install -m 0755 bin/mkrc $(PREFIX)/bin
	install -m 0755 bin/rcup $(PREFIX)/bin

.PHONY: install
