rcm
===

This is a management suite for dotfiles. **See [the tutorial][rcm7] to get
started quickly.**

It assumes that you have a separate dotfiles directory, or are
interested in creating one.

The programs provided are [rcup(1)][rcup1], [mkrc(1)][mkrc1], [rcdn(1)][rcdn1],
and [lsrc(1)][lsrc1]. They are explained in [the tutorial][rcm7] and configured
using [rcrc(5)][rcrc5].

Installation
------------

Arch Linux:

  https://aur.archlinux.org/packages/rcm-git/

Debian-based:

    wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb
    sudo dpkg -i rcm_1.2.3-1_all.deb

Gentoo-based (including Funtoo):

    sudo emerge layman
    sudo layman -f --overlays https://github.com/bronislav/overlays/raw/master/layman.xml --add bronislav
    sudo emerge rcm

OpenBSD (-current):

    sudo pkg_add rcm

openSUSE/RHEL/CentOS: [instructions](http://software.opensuse.org/download.html?project=utilities&package=rcm)

OS X:

    brew tap thoughtbot/formulae
    brew install rcm

Ubuntu (precise or trusty):

    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm

Elsewhere:

This uses the standard GNU autotools, so it's the normal dance:

    wget https://thoughtbot.github.io/rcm/dist/rcm-1.2.3.tar.gz && \
    tar -xvf rcm-1.2.3.tar.gz && \
    cd rcm-1.2.3 && \

    ./configure && \
    make && \
    make install

For more, see `INSTALL`.

Programs
--------

* [rcup(1)][rcup1] is the main program. It is used to install and update
  dotfiles, with support for tags, host-specific files, and multiple source
  directories.
* [rcdn(1)][rcdn1] is the opposite of [rcup(1)][rcup1].
* [mkrc(1)][mkrc1] is for introducing a dotfile into your dotfiles directory,
  with support for tags and multiple source directories.
* [lsrc(1)][lsrc1] shows you all your dotfiles and where they would be
  symlinked to. It is used by [rcup(1)][rcup1] but is provided for your own
  use, too.

[rcup1]: http://thoughtbot.github.io/rcm/rcup.1.html
[mkrc1]: http://thoughtbot.github.io/rcm/mkrc.1.html
[rcdn1]: http://thoughtbot.github.io/rcm/rcdn.1.html
[lsrc1]: http://thoughtbot.github.io/rcm/lsrc.1.html
[rcm7]: http://thoughtbot.github.io/rcm/rcm.7.html
[rcrc5]: http://thoughtbot.github.io/rcm/rcrc.5.html

Support
-------

Pull requests welcome; see `CONTRIBUTING.md`.

License
-------

Copyright 2013 Mike Burns. BSD license.
Copyright 2014 thoughtbot. BSD license.
