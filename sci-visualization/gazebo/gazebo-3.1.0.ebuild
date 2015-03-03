# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Gazebo 3d Simualtor"
HOMEPAGE="http://gazebosim.org/"
SRC_URI="http://gazebosim.org/assets/distributions/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cegui audio gts bullet xslt ronn test"

DEPEND="dev-libs/protobuf
		dev-libs/libtar
		dev-libs/tinyxml
		dev-libs/boost
		dev-util/cmake
		dev-vcs/mercurial
		dev-qt/qtcore:4
		net-misc/curl[curl_ssl_openssl]
		cegui? ( <dev-games/cegui-0.8 )
		audio? ( media-libs/openal )
		dev-cpp/tbb
		<dev-games/ogre-1.9
		gts? ( sci-libs/gts )
		dev-libs/libxml2
		media-libs/freeimage
		media-libs/freeglut
		bullet? ( sci-physics/bullet )
		xslt? ( dev-libs/libxslt )
		ronn? ( app-text/ronn )
		>sci-libs/sdformat-2.0.0
		"
#missing: libavformat-dev libavcodec-dev  libltdl3-dev playerc++
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE=RELEASE
