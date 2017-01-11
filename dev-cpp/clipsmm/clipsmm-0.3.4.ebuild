# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="C++ bindings for dev-lang/clips"
HOMEPAGE="http://clipsmm.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.bz2"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libsigc++
dev-lang/clips
virtual/pkgconfig
dev-util/cppunit
app-doc/doxygen
dev-libs/libxslt
sys-devel/m4
sys-devel/libtool"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}
