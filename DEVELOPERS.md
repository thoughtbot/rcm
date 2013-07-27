Developers
==========

GNU autoconf & automake
-----------------------

This project uses GNU autoconf and automake for installation and
building. To regenerate everything from first principles (`configure.ac`
and `**/Makefile.am`), run these commands:

    aclocal && \
    automake --add-missing --copy && \
    autoconf

Debian
------

First, everything must be set up just right:

    mkdir -p ~/debian/rcm && \
    cp -a rcm ~/debian/rcm/rcm-0.0.2 && \
    cd ~/debian/rcm && \
    rm -f rcm_0.0.2.orig.tar.gz && \
    rm -f rcm-0.0.2/tags && \
    tar --exclude=*swp --exclude-backups --exclude-vcs --exclude=debian -zcf rcm_0.0.2.orig.tar.gz rcm-0.0.2

Given that, now you can generate the Debian package:

    cd ~/debian/rcm/rcm-0.0.2 && \
    debuild -us -uc
