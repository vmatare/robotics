# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Driver for the Intel RealSense 3D camera"
HOMEPAGE="https://github.com/IntelRealSense"
SRC_URI="https://github.com/vmatare/librealsense/archive/v${PV}.tar.gz"

inherit cmake-utils

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+examples"

DEPEND="virtual/pkgconfig virtual/libusb
	examples? ( media-libs/glfw )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-cmake-don-t-call-ldconfig-during-install.patch"
)


src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES="$(usex examples)"
	)
	cmake-utils_src_configure
}
