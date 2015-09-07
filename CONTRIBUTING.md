Contributing
============

Overview
--------

- Make your changes.
- Update `NEWS.md.in`.
- Update `.mailmap` if necessary.
- Write a test covering your feature or fix.
- Ensure existing and new tests are passing.
- Submit a pull request on GitHub.

Explanation
-----------

Consider updating `NEWS.md.in`. The topmost section is for the upcoming
release. Bugfixes should be marked with `BUGFIX`. Small things (typos,
code style) should be grouped but with multiple authors (`Documentation
updates thanks to Dan Croak and Roberto Pedroso`).

We use your name and email address as produced by `git-shortlog(1)`. You
can change how this is formatted by modifying `.mailmap`. More details
on that file can be found in the git [Documentation/mailmap.txt][mailmap].

It is mandatory to include tests with pull requests. You must ensure that the
existing test suite passes with any changes you make. Also, any attempts to add
or extend tests will increase the chances of your pull request being merged.

Submit a pull request using GitHub. If there is a relevant bug, mention
it in the commit message (`Fixes #42.`). We love pull requests from everyone.
By participating in this project, you agree to abide by the thoughtbot
[code of conduct].

[mailmap]: https://github.com/git/git/blob/master/Documentation/mailmap.txt
[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

Setup
-----

1. Fork the repo.
2. Install dependencies

  - Cram is used for tests: `pip install cram`
  - The mustache gem for building the HTML pages: `gem install mustache`

3. Prepare the build system: `./autogen.sh`. (This depends on GNU
   autoconf and GNU automake.)
4. Configure the package: `./configure`.
5. Make sure the tests pass: `make check`.
6. Start hacking

Testing
-------

The test suite uses [cram][]. It is an integration suite, meaning the
programs are exercised from the outside and assertions are made only on
their output or effects.

The test suite requires Perl with the `Cwd` module. It expects to find Perl as
`perl` in `$PATH`.

All tests can be run like so:

    $ make check

Individual tests can be run like so:

    $ env TESTS=lsrc-dotfiles-dirs.t make -e check

If you intend to write a new test:

1. Add your test at `test/subcommand-something-meaningful.t`.
2. Add the relative name to the `TESTS` variable in `test/Makefile.am`.
3. Source `test/helper.sh` as the first line of your test.
4. When in doubt, use existing tests as a guide.

[cram]: https://bitheap.org/cram/
