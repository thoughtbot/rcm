#!/bin/sh

aclocal &&
  autoconf &&
  automake --add-missing --copy &&
  ./maint/autocontrib man/rcm.7.mustache
