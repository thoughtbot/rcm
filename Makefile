PREFIX=/usr/local

install:
	install -m 0755 bin/mkrc $(PREFIX)/bin
	install -m 0755 bin/rcup $(PREFIX)/bin
	install -m 0644 man/man1/rcup.1 $(PREFIX)/share/man/man1
	install -m 0644 man/man1/mkrc.1 $(PREFIX)/share/man/man1
	install -m 0644 man/man5/rcrc.5 $(PREFIX)/share/man/man1

.PHONY: install
