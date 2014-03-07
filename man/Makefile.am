dist_man_MANS = lsrc.1 mkrc.1 rcdn.1 rcup.1 rcrc.5 rcm.7

###### manpages as HTML
release_build_man_html:
	([ -d $(abs_top_builddir)/gh-pages ] || git clone --branch gh-pages --single-branch .. $(abs_top_builddir)/gh-pages) && \
	for i in $(dist_man_MANS); do \
	  mandoc -Thtml -Oman=%N.%S.html $$i > $(abs_top_builddir)/gh-pages/$$i.html ; \
	done && \
	cd $(abs_top_builddir)/gh-pages && \
	cp rcm.7.html index.html && \
	git add -A && \
	git commit -m "HTML documentation for $(PACKAGE_VERSION)"

release_push_man_html:
	cd $(abs_top_builddir)/gh-pages && \
		git push -f $(ORIGIN_URL) gh-pages

release_clean_man_html:
	rm -rf $(abs_top_builddir)/gh-pages
