AUTOMAKE_OPTIONS = foreign
SUBDIRS = man share bin

.PHONY: release deb-changelog build-tag push-tag deb build-docs upload-docs

ORIGIN_URL=$(shell git config --get remote.origin.url)

release: deb push-tag upload-docs

deb-changelog: NEWS.md
	cp -f NEWS.md debian/changelog

deb: deb-changelog
	mkdir /tmp/deb
	cp -a . /tmp/deb/rcm-$(PACKAGE_VERSION)
	cd /tmp/deb && \
	tar --exclude=*swp --exclude-backups --exclude-vcs --exclude=debian \
		--exclude=config.status --exclude=config.log \
		-zcf rcm_$(PACKAGE_VERSION).orig.tar.gz rcm-$(PACKAGE_VERSION) && \
	cd rcm-$(PACKAGE_VERSION) && \
	debuild -us -uc
	cp /tmp/deb/rcm_$(PACKAGE_VERSION)*.deb $(abs_srcdir)

build-tag:
	git tag -f -a v$(PACKAGE_VERSION) -m "Release $(PACKAGE_VERSION)"

push-tag: build-tag
	git push origin --tags

build-docs:
	git clone --branch gh-pages --single-branch . gh-pages && \
	for i in lsrc.1 mkrc.1 rcm.7 rcrc.5 rcup.1; do \
	  mandoc -Thtml -Oman=%N.%S.html man/$$i > gh-pages/$$i.html ; \
	done ; \
	cp gh-pages/rcm.7.html gh-pages/index.html

upload-docs: build-docs
	cd gh-pages ; \
	git commit -am "update pages" ; \
	git push -f $(ORIGIN_URL) gh-pages ; \
	cd .. && \
	rm -rf gh-pages
