#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#ifndef COMPAT_H
#define COMPAT_H

#ifdef __FreeBSD__
#define __dead __dead2
#endif /* __FreeBSD__ */

#if defined(__linux__) || defined(__CYGWIN__)
#ifdef __GNUC__
#define __dead		__attribute__((__noreturn__))
#else
#define __dead
#endif
#endif /* __linux__ || __CYGWIN__ */

#endif /* COMPAT_H */
