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

    ./configure
    make distcheck

On any system you can build the tarball, Homebrew package, and tag:

    ./maint/release build tarball rcm-*.tar.gz
    ./maint/release build homebrew rcm-*.tar.gz
    ./maint/release build tag rcm-*.tar.gz

You need mdocml to tranform the manpages into HTML:

    ./maint/release build man_html rcm-*.tar.gz

Once built, you can push it live:

    ./maint/release push tarball rcm-*.tar.gz
    ./maint/release push homebrew rcm-*.tar.gz
    ./maint/release push tag rcm-*.tar.gz
    ./maint/release push man_html rcm-*.tar.gz

And once pushed, you should clean up

    ./maint/release clean tarball rcm-*.tar.gz
    ./maint/release clean homebrew rcm-*.tar.gz
    ./maint/release clean tag rcm-*.tar.gz
    ./maint/release clean man_html rcm-*.tar.gz

4. Contact package maintainers:

| OS       | Name                       | Email                         | PGP keyid          |
| -------- | -------------------------- | ----------------------------- | ------------------ |
| Alpine   | Hiroshi Kajisha            | <kajisha@gmail.com>           | ?                  |
| Arch     | Max Falk                   | <gmdfalk@gmail.com>           | 0x9cbdc83ba3753845 |
| Debian   | Eric Collins               | <eric+debian@tabfugni.cc>     | 0x7BEB44E2771AB877 |
| Fedora   | Carl van Tonder            | <carl@supervacuo.com>         | 0xa478c47bcb683786 |
| Gentoo   | Florian Tham               | <fgtham@gmail.com>            | 0x7286dc0e62941423 |
| Korora   | Carl van Tonder            | <carl@supervacuo.com>         | 0xb55275fbcbe8383c |
| Homebrew | Mike Burns                 | <mburns@thoughtbot.com>       | 0x3E6761F72846B014 |
| MacPorts | Aljaž Srebrnič             | <a2piratesoft@gmail.com>      | 0xe140e1eea54ee677 |
| OpenBSD  | Mike Burns                 | <mike+openbsd@mike-burns.com> | 0x3E6761F72846B014 |
| openSUSE | Andrei Dziahel             | <develop7@develop7.info>      | 0x58BA3FA4A49D76C2 |
| Ubuntu   | Martin Frost               | <frost@ceri.se>               | 0x4609D1E5ECA538E6 |
| Void     | maxice8                    | <thinkabit.ukim@gmail.com>    | 0xffaeeb9ca1c95204 |
