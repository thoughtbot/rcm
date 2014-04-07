AUTOMAKE_OPTIONS = foreign
SUBDIRS = man Rcm test
EXTRA_DIST = LICENSE README.md NEWS.md

.PHONY: release \
	release_build release_push release_clean \
	release_build_tarball release_build_homebrew release_build_arch \
	release_push_tarball release_push_homebrew release_push_arch \
	release_clean_tarball release_clean_homebrew release_clean_arch \
	release_build_deb release_push_deb release_clean_deb release_build_tag \
	release_push_tag release_clean_tag release_build_man_html \
	release_push_man_html release_clean_man_html

# Taken from http://marc.info/?l=haskell&m=120492272511651&w=2

.hs.o:
	$(COMPILE) -o $@ $<

bin_PROGRAMS = lsrc
dist_lsrc_SOURCES = Rcm/Lsrc.hs Rcm/Private/Data.hs Rcm/Private/Lsrc.hs Rcm/Private/Dotfiles.hs Rcm/GetOpt.hs Rcm/Util.hs

AM_GHC_DEPEND_FLAGS = -no-hs-main --make -pgmltrue -odir . -hidir .

DEFAULT_INCLUDES = -i$(srcdir)

GHC_PACKAGES = -package filepath -package unix -package directory

AM_GHC_MAIN = -main-is Rcm.Lsrc
AM_GHC_COMPILE_FLAGS = $(DEFS) $(GHC_PACKAGES) \
	  	  $(DEFAULT_INCLUDES) $(INCLUDES) \
	  	  $(AM_GHCFLAGS) $(GHCFLAGS) $(AM_GHC_MAIN)
AM_GHC_LINK_FLAGS = $(AM_GHC_MAIN)

COMPILE = $(GHC) $(AM_GHC_DEPEND_FLAGS) $(AM_GHC_COMPILE_FLAGS)
LINK = $(GHC) $(GHC_PACKAGES) $(AM_LDFLAGS) $(AM_GHC_LINK_FLAGS) $(GHCFLAGS) -o $@
CLEANFILES = *.hi

# Release:

ORIGIN_URL=$(shell git config --get remote.origin.url)
CURRENT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

edit_package = sed \
	-e 's|@PACKAGE[@]|$(PACKAGE)|g' \
	-e 's|@PACKAGE_VERSION[@]|$(PACKAGE_VERSION)|g' \
	-e 's|@DIST_ARCHIVES[@]|$(DIST_ARCHIVES)|g' \
	-e 's|@DIST_SHA[@]|$(DIST_SHA)|g'

release: release_build release_push release_clean

release_build: release_build_tarball release_build_homebrew release_build_arch \
	release_build_deb release_build_tag release_build_man_html

release_push: release_push_tarball release_push_homebrew release_push_arch \
	release_push_deb release_push_tag release_push_man_html

release_clean: release_clean_tarball release_clean_homebrew release_clean_arch \
	release_clean_deb release_clean_tag release_clean_man_html

###### Tarball
release_build_tarball: Makefile distcheck
	([ -d gh-pages ] || git clone --branch gh-pages . gh-pages) && \
		([ -d gh-pages/dist ] || mkdir gh-pages/dist) && \
		cp $(DIST_ARCHIVES) gh-pages/dist && \
		cd gh-pages &&\
			git add dist/$(DIST_ARCHIVES) &&\
			git commit -m "Release version $(PACKAGE_VERSION) tarball"

release_push_tarball:
	cd gh-pages &&\
		git push

release_clean_tarball:
	rm -rf gh-pages
	rm -rf $(DIST_ARCHIVES)

###### Homebrew
release_build_homebrew: DIST_SHA
	([ -d homebrew-formulae ] || git clone git@github.com:thoughtbot/homebrew-formulae.git homebrew-formulae) && \
		$(edit_package) homebrew/$(PACKAGE).rb.in > homebrew-formulae/Formula/$(PACKAGE).rb && \
		cd homebrew-formulae &&\
		git commit -am "$(PACKAGE): Release version $(PACKAGE_VERSION)"

release_push_homebrew:
	cd homebrew-formulae &&\
		git push

release_clean_homebrew:
	rm -rf homebrew-formulae
	rm -rf $(DIST_ARCHIVES)

###### Arch
release_build_arch: DIST_SHA
	([ -d gh-pages ] || git clone --branch gh-pages . gh-pages) && \
		([ -d gh-pages/arch ] || mkdir gh-pages/arch) && \
		$(edit_package) arch/PKGBUILD.in > gh-pages/arch/PKGBUILD &&\
		cd gh-pages &&\
			git add arch/PKGBUILD &&\
			git commit -m "Release version $(PACKAGE_VERSION) Arch package"

release_push_arch:
	cd gh-pages &&\
		git push

release_clean_arch:
	rm -rf gh-pages
	rm -rf $(DIST_ARCHIVES)

###### Deb
release_build_deb: NEWS.md DIST_SHA distcheck
	([ -d deb-build ] || mkdir -p deb-build) && \
		cp $(DIST_ARCHIVES) deb-build/$(PACKAGE)_$(PACKAGE_VERSION).orig.tar.gz && \
		tar -C deb-build -xf deb-build/$(PACKAGE)_$(PACKAGE_VERSION).orig.tar.gz && \
		cp -R debian deb-build/$(PACKAGE)-$(PACKAGE_VERSION) && \
		cd deb-build/$(PACKAGE)-$(PACKAGE_VERSION) && \
		dch -d "New upstream release" && dch -r "" && \
		cp debian/changelog $(abs_srcdir)/debian/changelog && \
		debuild -us -uc && \
		cd $(abs_srcdir) && \
		([ -d gh-pages ] || git clone --branch gh-pages $(ORIGIN_URL) gh-pages) && \
		([ -d gh-pages/debs ] || mkdir gh-pages/debs) && \
		cp deb-build/$(PACKAGE)_$(PACKAGE_VERSION)*.deb gh-pages/debs && \
		cd gh-pages && \
		git add debs/$(PACKAGE)_$(PACKAGE_VERSION)*deb && \
		git commit -m "Release version $(PACKAGE_VERSION) for Debian" -- debs/$(PACKAGE)_$(PACKAGE_VERSION)*deb

release_push_deb:
	cd gh-pages && \
		git push

release_clean_deb:
	rm -rf gh-pages
	rm -rf deb-build
	rm -rf $(DIST_ARCHIVES)

###### Tag
release_build_tag:
	git tag -s v$(PACKAGE_VERSION) -m "Release $(PACKAGE_VERSION)"

release_push_tag:
	git push origin --tags

release_clean_tag:

DIST_SHA: Makefile distcheck
	$(eval DIST_SHA := $(shell shasum $(srcdir)/$(DIST_ARCHIVES) | cut -d' ' -f1))
