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
