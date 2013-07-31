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

Given that, now you can generate the Debian package. This requires the
Debian packaging tools, especially debuild:

    cd ~/debian/rcm/rcm-0.0.2 && \
    debuild -us -uc

HTML documentation
------------------

The HTML documentation can be generated using the mdocml suite,
especially mandoc(1). This shell command will generate them all into a
separate `rcm-gh-pages` directory:

    for i in lsrc.1 mkrc.1 rcm.7 rcrc.5 rcup.1; do
      mandoc -Thtml -Oman=%N.%S.html man/$i > ~/rcm-gh-pages/$i.html
    done
    cp ~/rcm-gh-pages/rcm.7.html ~/rcm-gh-pages/index.html

More information on mdocml can be found on http://mdocml.bsd.lv/ .
