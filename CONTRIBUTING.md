Contributing
============

Overview
--------

- We do not currently have a test suite.
- Update `NEWS.md.in`.
- Update `.mailmap`.
- Submit a pull request on GitHub.

Explanation
-----------

Since we do not yet have a test suite, you should make sure to install
and try your patch in a various scenarios. We will also entertain a
contribution with a test case.

Consider updating `NEWS.md.in`. The topmost section is for the upcoming
release. Bugfixes should be marked with `BUGFIX`. Small things (typos,
code style) should be grouped but with multiple authors (`Documentation
updates thanks to Dan Croak and Roberto Pedroso`).

We use your name and email address as produced by `git-shortlog(1)`. You
can change how this is formatted by modifying `.mailmap`. More details
on that file can be found in the git [Documentation/mailmap.txt][mailmap].

Submit a pull request using GitHub. If there is a relevant bug, mention
it in the commit message (`Fixes #42.`).

[mailmap]: https://github.com/git/git/blob/6a907786af835ac15962be53f1492f2
