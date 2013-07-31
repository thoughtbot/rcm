#!/bin/sh

aclocal && \
  automake --add-missing --copy && \
  autoconf
