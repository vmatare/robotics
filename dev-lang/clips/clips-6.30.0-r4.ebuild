# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit rpm autotools

SVNREL="20090722svn"

DESCRIPTION="Language for developing expert systems"
HOMEPAGE="http://clipsrules.sourceforge.net/"
SRC_URI="http://ftp.halifax.rwth-aachen.de/fedora/linux/releases/31/Everything/source/tree/Packages/c/clips-${PV}-0.20.${SVNREL}.fc31.src.rpm"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="sys-libs/ncurses[tinfo]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/clips-${PV}.${SVNREL}"

DOCS_BASE="${S}-doc"

src_prepare() {
	mv "${DOCS_BASE}"/* "${S}"/documentation
	cd "${S}"
	sed -i 's/termcap/tinfo/g' clips-6.pc.in config.h.in configure configure.ac
	mkdir m4
	default
}

src_configure() {
	eautoreconf
	default
}

src_install() {
	cd "$S"

	# The Makefile in the documentation subdir causes sandbox violations by writing to /usr/share ...
	sed -i 's/SUBDIRS\s*=\s*clips\s\+x_window_system\s\+documentation\s*/SUBDIRS = clips x_window_system/' Makefile

	# ... so we install documentation manually
	DOCS=( documentation/*.pdf documentation/*.doc documentation/*.el )
	DOCS=( ${DOCS[@]} $(find examples -type f) )

	default
	if use doc; then
		for d in ${DOCS[@]}; do
			dodoc $DOCS
		done
		dohtml -r documentation/html/*
	fi
}
