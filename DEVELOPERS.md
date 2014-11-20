Developers
==========

Making a release
----------------

1. Bump the version within the `AC_INIT` macro call in `configure.ac`.

2. Update the build system by running: `./autogen.sh`.

3. Build the trivial packages:

This all depends on a `gh-pages` branch:

    git branch gh-pages origin/gh-pages

First build the distribution:

    make distcheck

On any system you can build the tarball, Homebrew package, Arch
PKGBUILD, and tag:

    ./maint/release build tarball rcm-*.tar.gz
    ./maint/release build homebrew rcm-*.tar.gz
    ./maint/release build arch rcm-*.tar.gz
    ./maint/release build tag rcm-*.tar.gz

You need mdocml to tranform the manpages into HTML:

    ./maint/release build man_html rcm-*.tar.gz

Once built, you can push it live:

    ./maint/release push tarball rcm-*.tar.gz
    # ... etc. ...

And once pushed, you should clean up

    ./maint/release clean tarball rcm-*.tar.gz
    # ... etc. ...

4. Build the Debian package:

Only on Debian systems can you build the Debian package:

    make NEWS.md
    ./maint/release build deb rcm-*.tar.gz
    ./maint/release push deb rcm-*.tar.gz
    ./maint/release clean deb rcm-*.tar.gz

5. Contact package maintainers:

Gentoo   Anton Ilin     <anton@ilin.dn.ua>            0xCB2AA11FEB76CE36
OpenBSD  Mike Burns     <mike+openbsd@mike-burns.com> 0x3E6761F72846B014
openSUSE Andrei Dziahel <develop7@develop7.info>      0x58BA3FA4A49D76C2
Ubuntu   Martin Frost   <frost@ceri.se>               0x98624E2FE507FAF2
