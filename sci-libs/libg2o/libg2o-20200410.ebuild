# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="C++ framework for optimizing graph-based nonlinear error functions"
HOMEPAGE="http://openslam.org/g2o.html"
SRC_URI="https://github.com/RainerKuemmerle/g2o/archive/${PV}_git.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sci-libs/suitesparse
	dev-cpp/eigen"
RDEPEND="${DEPEND}"

S="${WORKDIR}/g2o-${PV}_git"

src_prepare() {
	epatch "${FILESDIR}/libdir2.patch"
}
