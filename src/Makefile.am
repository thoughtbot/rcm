# Taken from http://marc.info/?l=haskell&m=120492272511651&w=2

.hs.o:
	$(COMPILE) -o $@ $<

bin_PROGRAMS = hello
dist_hello_SOURCES = Main.hs

AM_GHC_DEPEND_FLAGS = -no-hs-main --make -pgmltrue -odir . -hidir .

DEFAULT_INCLUDES = -i$(srcdir)

AM_GHC_COMPILE_FLAGS = $(DEFS) $(GHC_PACKAGES) \
	  	  $(DEFAULT_INCLUDES) $(INCLUDES) \
	  	  $(AM_GHCFLAGS) $(GHCFLAGS)

COMPILE = $(GHC) $(AM_GHC_DEPEND_FLAGS) $(AM_GHC_COMPILE_FLAGS)
LINK = $(GHC) $(GHC_PACKAGES) $(AM_LDFLAGS) $(GHCFLAGS) -o $@
CLEANFILES = *.hi
