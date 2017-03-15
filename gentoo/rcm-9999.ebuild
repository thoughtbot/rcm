# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="rc file (dotfile) management"
HOMEPAGE="https://github.com/thoughtbot/rcm"
EGIT_REPO_URI="https://github.com/thoughtbot/rcm.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-ruby/mustache"
RDEPEND="${DEPEND}"

src_prepare () {
	cd ${S}
	./autogen.sh
	default
}
