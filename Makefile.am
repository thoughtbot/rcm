AUTOMAKE_OPTIONS = foreign
EXTRA_DIST = LICENSE README.md NEWS.md

dist_bin_SCRIPTS = bin/lsrc bin/mkrc bin/rcup bin/rcdn

# When changing this you must also change maint/release.in .
dist_man_MANS = man/lsrc.1 man/mkrc.1 man/rcdn.1 man/rcup.1 man/rcrc.5 man/rcm.7

dist_pkgdata_DATA = share/rcm.sh

TESTS = \
	test/lsrc-dotfiles-dirs.t \
	test/lsrc-excludes.t \
	test/lsrc-hostname.t \
	test/lsrc-sigils.t \
	test/lsrc.t \
	test/lsrc-symlink-dirs.t \
	test/lsrc-spaces.t \
	test/lsrc-tags.t \
	test/lsrc-usage.t \
	test/lsrc-undotted.t \
	test/lsrc-undotted-star.t \
	test/lsrc-host-tags-default.t \
	test/lsrc-globs.t \
	test/mkrc-alternate-dotfiles-dir.t \
	test/mkrc-copy-file.t \
	test/mkrc-hooks.t \
	test/mkrc-host-file.t \
	test/mkrc-hostname.t \
	test/mkrc-no-dotfiles-dir-found.t \
	test/mkrc-no-symlinks.t \
	test/mkrc-one-dotfile-arg.t \
	test/mkrc-simple-output.t \
	test/mkrc-spaces.t \
	test/mkrc-symlink-dirs.t \
	test/mkrc-tagged-file.t \
	test/mkrc-usage.t \
	test/mkrc-undotted.t \
	test/rcrc-custom.t \
	test/rcrc-tilde.t \
	test/rcrc-hostname.t \
	test/rcrc-lsrc-excludes.t \
	test/rcrc.t \
	test/rcup-link-files.t \
	test/rcup-hostname.t \
	test/rcup-standalone.t \
	test/rcup-symlink-dirs.t \
	test/rcup-symlink-existing.t \
	test/rcup-usage.t \
	test/rcdn-hooks.t \
	test/rcdn-hooks-failure.t \
	test/rcdn-hooks-run-in-situ.t \
	test/rcdn-hooks-run-in-order.t \
	test/rcup-hooks.t \
	test/rcup-hooks-failure.t \
	test/rcup-hooks-run-in-situ.t \
	test/rcup-hooks-run-in-order.t \
	test/rcup-spaces.t \
	test/xdg.t \
	test/xdg-compatibilty-rcrc-symlink.t \
	test/xdg-config-with-dotfiles.t \
	test/xdg-error-both-config.t \
	test/xdg-favor-rcm_dotfiles-over-tilde_dotfiles.t

dist_check_SCRIPTS = $(TESTS)
dist_check_DATA = test/helper.sh

LOG_COMPILER = cram
