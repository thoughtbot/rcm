Developers
==========

GNU autoconf & automake
-----------------------

This project uses GNU autoconf and automake for installation and
building. To regenerate everything from first principles (`configure.ac`
and `**/Makefile.am`), run the command:

    ./autogen.sh

Debian
------

First, everything must be set up just right:

    mkdir -p ~/debian/rcm && \
    cp -a rcm ~/debian/rcm/rcm-0.0.2 && \
    cd ~/debian/rcm && \
    rm -f rcm_0.0.2.orig.tar.gz && \
    rm -f rcm-0.0.2/tags && \
    tar --exclude=*swp --exclude-backups --exclude-vcs --exclude=debian --exclude=config.status --exclude=config.log -zcf rcm_0.0.2.orig.tar.gz rcm-0.0.2

Given that, now you can generate the Debian package. This requires the
Debian packaging tools, especially debuild:

    cd ~/debian/rcm/rcm-0.0.2 && \
    debuild -us -uc

HTML documentation
------------------

The HTML documentation is generated using the mdocml suite. Use the
`upload-docs` make target to rebuild the HTML docs and upload them to
GitHub Pages. The `build-docs` target will just build them.

    make upload-docs

More information on mdocml can be found on http://mdocml.bsd.lv/ .

Testing
-------

Acceptance tests can be executed by [cram][]:

~~~
$ make
$ SRC=$PWD cram test
...
# Ran 3 tests, 0 skipped, 0 failed.
~~~

It is encouraged that any new feature come with tests and that 
additional coverage should be added as time allows.

[cram]: https://bitheap.org/cram/
