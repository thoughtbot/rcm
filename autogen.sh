#!/bin/sh

aclocal -I m4 && autoconf && automake --add-missing --copy
