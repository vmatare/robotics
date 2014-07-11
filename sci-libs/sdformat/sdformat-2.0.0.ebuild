# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Simulation Desctiption Format API"
HOMEPAGE="http://sdformat.org/"
SRC_URI="http://gazebosim.org/assets/distributions/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/tinyxml"
RDEPEND="${DEPEND}"
