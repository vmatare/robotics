# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="ALVAR AR-Tag detection library"
HOMEPAGE="http://virtual.vtt.fi/virtual/proj2/multimedia/alvar/index.html"
SRC_URI="${P}-src.tar.gz"
RESTRICT="fetch"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=media-libs/opencv-2.4.0
		media-libs/freeglut"
RDEPEND="${DEPEND}"

S=${S}-src

pkg_nofetch() {
	einfo "Please download ${P}-src.tar.gz from ${HOMEPAGE} and lpace it in ${DISTDIR}"
}

src_prepare(){
	epatch ${FILESDIR}/${P}.readlink.patch
	epatch ${FILESDIR}/${P}.sane_install.patch
}

src_install(){
	cd ${WORKDIR}/${P}_build
	emake DESTDIR=${D} install
	echo "removing ${D}/usr/LICENSE"
	rm ${D}/usr/LICENSE
	echo "removing ${D}/usr/bin"
	rm -r ${D}/usr/bin
	echo "removing ${D}/usr/doc"
	rm -r ${D}/usr/doc
}
