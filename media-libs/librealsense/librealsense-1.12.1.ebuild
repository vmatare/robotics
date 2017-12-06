# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Driver for the Intel RealSense 3D camera"
HOMEPAGE="https://github.com/IntelRealSense"
SRC_URI="https://github.com/IntelRealSense/librealsense/archive/v${PV}.tar.gz"

inherit cmake-utils

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pkgconfig virtual/libusb"
RDEPEND="${DEPEND}"

