AUTOMAKE_OPTIONS = foreign
SUBDIRS = man share bin test
EXTRA_DIST = LICENSE README.md NEWS.md m4
ACLOCAL_AMFLAGS = -I m4

.PHONY: release

release: NEWS.md Makefile distcheck
	maint/release build tarball $(DIST_ARCHIVES)
	maint/release build homebrew $(DIST_ARCHIVES)
	maint/release build arch $(DIST_ARCHIVES)
	maint/release build deb $(DIST_ARCHIVES)
	maint/release build tag $(DIST_ARCHIVES)
	maint/release build man_html $(DIST_ARCHIVES)
	maint/release push tarball $(DIST_ARCHIVES)
	maint/release push homebrew $(DIST_ARCHIVES)
	maint/release push arch $(DIST_ARCHIVES)
	maint/release push deb $(DIST_ARCHIVES)
	maint/release push tag $(DIST_ARCHIVES)
	maint/release push man_html $(DIST_ARCHIVES)
	maint/release clean tarball $(DIST_ARCHIVES)
	maint/release clean homebrew $(DIST_ARCHIVES)
	maint/release clean arch $(DIST_ARCHIVES)
	maint/release clean deb $(DIST_ARCHIVES)
	maint/release clean tag $(DIST_ARCHIVES)
	maint/release clean man_html $(DIST_ARCHIVES)
