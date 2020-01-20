# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Open Source C++ and Python OPC-UA Server and Client Libraries and Tools"
HOMEPAGE="https://freeopcua.github.io/"
EGIT_REPO_URI="https://github.com/FreeOpcUa/freeopcua.git"

LICENSE="GPLv3"
SLOT="0"
IUSE="server +client python test ssl"

DEPEND="
	dev-libs/boost
	dev-util/cmake
	test? ( dev-cpp/gtest )
	ssl? ( net-libs/mbedtls )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs+=(
		-DBUILD_SERVER=$(usex server)
		-DBUILD_CLIENT=$(usex client)
		-DBUILD_PYTHON=$(usex python)
		-DBUILD_TESTING=$(usex test)
		-DSSL_SUPPORT_MBEDTLS=$(usex ssl)
	)
	cmake-utils_src_configure
}
