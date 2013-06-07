rcm
===

This is a management suite for dotfiles.

It assumes that you have a separate dotfiles directory, or are
interested in creating one.

The programs provided are `rcup` and `mkrc`.

Installation
------------

You can install into `/usr/local` using a normal `make install`:

    sudo make install

The `PREFIX` can be changed as needed:

    make install PREFIX=$HOME/.local

Programs
--------

* `rcup` is the main program. It is used to install and update dotfiles,
  with support for tags and host-specific files.
* `mkrc` is for introducing a dotfile into your dotfiles directory, with
  support for tags.

Support
-------

Pull requests welcome.

License
-------

Copyright 2013 Mike Burns. BSD license.
