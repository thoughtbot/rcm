# Taken from http://marc.info/?l=haskell&m=120492272511651&w=2

.hs.o:
	$(COMPILE) -o $@ $<

bin_PROGRAMS = lsrc

dist_lsrc_SOURCES = Rcm/Lsrc.hs Rcm/Private/Data.hs Rcm/Private/Lsrc.hs Rcm/Private/Dotfiles.hs Rcm/GetOpt.hs Rcm/Util.hs

AM_GHC_DEPEND_FLAGS = -no-hs-main --make -pgmltrue -odir . -hidir .

DEFAULT_INCLUDES = -i$(srcdir)

GHC_PACKAGES = -package filepath -package unix -package directory

AM_GHC_MAIN = -main-is Rcm.Lsrc
AM_GHC_COMPILE_FLAGS = $(DEFS) $(GHC_PACKAGES) \
	  	  $(DEFAULT_INCLUDES) $(INCLUDES) \
	  	  $(AM_GHCFLAGS) $(GHCFLAGS) $(AM_GHC_MAIN)
AM_GHC_LINK_FLAGS = $(AM_GHC_MAIN)

COMPILE = $(GHC) $(AM_GHC_DEPEND_FLAGS) $(AM_GHC_COMPILE_FLAGS)
LINK = $(GHC) $(GHC_PACKAGES) $(AM_LDFLAGS) $(AM_GHC_LINK_FLAGS) $(GHCFLAGS) -o $@

CLEANFILES = *.hi
