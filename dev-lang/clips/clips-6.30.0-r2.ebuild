# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit rpm

SVNREL="20090722svn"

DESCRIPTION="Language for developing expert systems"
HOMEPAGE="http://clipsrules.sourceforge.net/"
SRC_URI="http://ftp.halifax.rwth-aachen.de/fedora/linux/releases/28/Everything/source/tree/Packages/c/clips-${PV}-0.17.${SVNREL}.fc28.src.rpm"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="sys-libs/libtermcap-compat"
RDEPEND="${DEPEND}"

S="${WORKDIR}/clips-${PV}.${SVNREL}"

DOCS_BASE="${S}-doc"

src_prepare() {
	mv "${DOCS_BASE}"/* "${S}"/documentation
}

src_install() {
	cd "$S"

	# The Makefile in the documentation subdir causes sandbox violations by writing to /usr/share ...
	sed -i 's/SUBDIRS\s*=\s*clips\s\+x_window_system\s\+documentation\s*/SUBDIRS = clips x_window_system/' Makefile

	# ... so we install documentation manually
	DOCS=( documentation/*.pdf documentation/*.doc documentation/*.el )
	DOCS=( ${DOCS[@]} $(find examples -type f) )

	einstall
	if use doc; then
		for d in ${DOCS[@]}; do
			dodoc $DOCS
		done
		dohtml -r documentation/html/*
	fi
}
