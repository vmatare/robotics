# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="An environment for developing constraint-based applications"
HOMEPAGE="http://www.gecode.org/"
SRC_URI="https://github.com/Gecode/gecode/archive/release-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples +gist debug +mpfr +threads"

RDEPEND="
	gist? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
	)
	dev-libs/gmp:0
	mpfr? ( dev-libs/mpfr:0 )
"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)"

S="${WORKDIR}/${PN}-release-${PV}"

src_configure() {
	econf \
		$(use_enable gist) \
		$(use_enable debug) \
		$(use_enable threads thread) \
		$(use_enable examples) \
		$(use_enable mpfr)
}

src_install() {
	default

	if use examples; then
		dodoc -r examples
	fi
}
