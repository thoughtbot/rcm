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

  https://aur.archlinux.org/packages/rcm/

Debian-based:

    wget https://thoughtbot.github.io/rcm/debs/rcm_1.3.0-1_all.deb
    sha=$(sha256sum rcm_1.3.0-1_all.deb | cut -f1 -d' ')
    [ "$sha" = "2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d" ] && \
    sudo dpkg -i rcm_1.3.0-1_all.deb

OpenBSD (-current):

    doas pkg_add rcm

Fedora 21/22/23:

    sudo dnf copr enable seeitcoming/rcm
    sudo dnf install rcm

FreeBSD:

    sudo pkg install rcm

openSUSE/RHEL/CentOS: [instructions](http://software.opensuse.org/download.html?project=utilities&package=rcm)

OS X:

    brew tap thoughtbot/formulae
    brew install rcm

Ubuntu:

    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm

Elsewhere:

This uses the standard GNU autotools, so it's the normal dance:

    curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.0.tar.gz && \

    sha=$(sha256 rcm-1.3.0.tar.gz | cut -f1 -d' ') && \
    [ "$sha" = "502fd44e567ed0cfd00fb89ccc257dac8d6eb5d003f121299b5294c01665973f" ] && \

    tar -xvf rcm-1.3.0.tar.gz && \
    cd rcm-1.3.0 && \

    ./configure && \
    make && \
    sudo make install

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
Copyright 2014-2015 thoughtbot. BSD license.

## About thoughtbot

![thoughtbot](https://thoughtbot.com/logo.png)

RCM is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We adore open source software.
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
