Contributing
============

Overview
--------

- Update `NEWS.md.in`.
- Update `.mailmap`.
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

Our test suite is new, and therefore it is not yet mandatory to include 
tests with pull requests. However, you must ensure that the existing 
test suite passes with any changes you make. Also, any attempts to add 
or extend tests will increase the chances of your pull request being 
merged.

Submit a pull request using GitHub. If there is a relevant bug, mention
it in the commit message (`Fixes #42.`).

[mailmap]: https://github.com/git/git/blob/master/Documentation/mailmap.txt

Testing
-----

The test suite uses [cram][]. It is an integration suite, meaning the 
programs are exercised from the outside and assertions are made only on 
their output or effects.

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
