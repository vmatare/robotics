# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils eutils

DESCRIPTION="ALVAR AR-Tag detection library"
HOMEPAGE="http://virtual.vtt.fi/virtual/proj2/multimedia/alvar/index.html"
SRC_URI="https://github.com/vmatare/alvar/archive/${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND=">=media-libs/opencv-2.4.0
		media-libs/freeglut
		dev-libs/tinyxml
		doc? ( app-doc/doxygen )"
RDEPEND="${DEPEND}"

