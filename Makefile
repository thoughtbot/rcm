PREFIX=/usr/local

install:
	install -dm 0755 $(PREFIX)/bin
	install -dm 0755 $(PREFIX)/share/man/man1
	install -dm 0755 $(PREFIX)/share/man/man5
	install -dm 0755 $(PREFIX)/libexec/rcm
	install -m 0755 bin/mkrc $(PREFIX)/bin
	install -m 0755 bin/rcup $(PREFIX)/bin
	install -m 0755 bin/lsrc $(PREFIX)/bin
	install -m 0644 man/man1/rcup.1 $(PREFIX)/share/man/man1
	install -m 0644 man/man1/mkrc.1 $(PREFIX)/share/man/man1
	install -m 0644 man/man1/lsrc.1 $(PREFIX)/share/man/man1
	install -m 0644 man/man5/rcrc.5 $(PREFIX)/share/man/man5
	install -m 0644 libexec/rcm/rcm.sh $(PREFIX)/libexec/rcm

uninstall:
	rm -f $(PREFIX)/bin/mkrc
	rm -f $(PREFIX)/bin/rcup
	rm -f $(PREFIX)/bin/lsrc
	rm -f $(PREFIX)/man/man1/rcup.1
	rm -f $(PREFIX)/man/man1/mkrc.1
	rm -f $(PREFIX)/man/man1/lsrc.1
	rm -f $(PREFIX)/man/man5/rcrc.5
	rm -f $(PREFIX)/libexec/rcm/rcm.sh
	rmdir $(PREFIX)/libexec/rcm

.PHONY: install uninstall
