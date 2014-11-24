Developers
==========

Making a release
----------------

1. Bump the version within the `AC_INIT` macro call in `configure.ac`.

2. Update the build system by running: `./autogen.sh`.

3. Build the packages:

This all depends on a `gh-pages` branch:

    git branch gh-pages origin/gh-pages

On any system you can build the tarball, Homebrew package, Arch
PKGBUILD, and tag:

    make release_build_tarball release_build_homebrew release_build_arch \
	    release_build_tag

You need mdocml to tranform the manpages into HTML:

    make release_build_man_html

Only on Debian systems can you build the Debian package:

    make release_build_deb

If you are on a Debian system with mdocml, here is a shortcut:

    make release_build

From here you can push these:

    make release_push_tarball release_push_homebrew release_push_arch \
	    release_push_tag release_push_man_html
    make release_push_deb

Or, all at once:

    make release_push

You can clean individual steps:

    make release_clean_tarball release_clean_homebrew release_clean_arch \
      release_clean_deb release_clean_tag release_clean_man_html

Or, again, everything at once:

    make release_clean

If you are on a Debian system, have mdocml installed, have an absurd
amount of trust in the system, and know how to debug it intimately, give
everything a go:

    make release
