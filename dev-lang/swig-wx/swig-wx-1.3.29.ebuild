# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="SWIG customized for ros"
HOMEPAGE="https://github.com/ros/swig-wx/"
SRC_URI="https://github.com/ros/swig-wx/archive/fuerte-devel.zip"

LICENSE=""
SLOT="FUERTE"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/yacc
		!sys-devel/bison
		!dev-lang/swig"
RDEPEND="${DEPEND}"

S=${WORKDIR}/swig-wx-fuerte-devel

src_configure() {
	${S}/autogen.sh
	econf
}
