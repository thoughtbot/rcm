rcm
===

This is a management suite for dotfiles.

It assumes that you have a separate dotfiles directory, or are
interested in creating one.

The programs provided are `rcup`, `mkrc`, and `lsrc`.

Installation
------------

You can install into `/usr/local` using a normal `make install`:

    sudo make install

The `PREFIX` can be changed as needed:

    make install PREFIX=$HOME/.local

Programs
--------

* `rcup` is the main program. It is used to install and update dotfiles,
  with support for tags, host-specific files, and multiple source
  directories.
* `mkrc` is for introducing a dotfile into your dotfiles directory, with
  support for tags and multiple source directories.
* `lsrc` shows you all your dotfiles and where they would be symlinked
  to. It is used by `rcup` but is provided for your own use, too.

Support
-------

Pull requests welcome.

License
-------

Copyright 2013 Mike Burns. BSD license.
