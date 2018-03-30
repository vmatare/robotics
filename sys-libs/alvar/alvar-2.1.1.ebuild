# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils eutils

DESCRIPTION="ALVAR AR-Tag detection library"
HOMEPAGE="http://virtual.vtt.fi/virtual/proj2/multimedia/alvar/index.html"
SRC_URI="https://github.com/vmatare/alvar/archive/${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=media-libs/opencv-2.4.0
		media-libs/freeglut
		dev-libs/tinyxml"
RDEPEND="${DEPEND}"

#src_prepare(){
#	epatch ${FILESDIR}/${P}.readlink.patch
#	epatch ${FILESDIR}/${P}.install.patch
#	epatch ${FILESDIR}/${P}.system_tinyxml.patch
#	epatch ${FILESDIR}/${P}.omit_sample.patch
#}
#
#src_install(){
#	cd ${WORKDIR}/${P}_build
#	emake DESTDIR=${D} install
#	mv ${D}usr/lib64/libalvar.so ${D}usr/lib64/libalvar.so.2.0.0
#	ln -s libalvar.so.2.0.0 ${D}usr/lib64/libalvar.so.2
#	ln -s libalvar.so.2 ${D}usr/lib64/libalvar.so
#	echo "removing ${D}usr/LICENSE"
#	rm ${D}usr/LICENSE
#	echo "removing ${D}usr/bin"
#	rm -r ${D}usr/bin
#	echo "removing ${D}usr/doc"
#	rm -r ${D}usr/doc
#}
