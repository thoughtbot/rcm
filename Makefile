PREFIX=/usr/local

install:
	install -Dm 0755 bin/mkrc $(PREFIX)/bin/mkrc
	install -Dm 0755 bin/rcup $(PREFIX)/bin/rcup
	install -Dm 0644 man/man1/rcup.1 $(PREFIX)/share/man/man1/rcup.1
	install -Dm 0644 man/man1/mkrc.1 $(PREFIX)/share/man/man1/mkrc.1
	install -Dm 0644 man/man5/rcrc.5 $(PREFIX)/share/man/man5/rcrc.5

.PHONY: install
