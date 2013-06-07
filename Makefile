PREFIX=/usr/local

install:
	install -m 0755 bin/mkrc $(PREFIX)/bin
	install -m 0755 bin/rcup $(PREFIX)/bin
	install -m 0644 man/man1/rcup.1 $(PREFIX)/share/man/man1

.PHONY: install
