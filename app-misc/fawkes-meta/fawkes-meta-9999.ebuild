# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="meta package for fawkes deps"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

inherit user

DEPEND_ALL_REQ="
	>=sys-devel/make-3.81
	>=app-shells/bash-3.2
	>=sys-devel/gcc-4.2
	>=sys-libs/glibc-2.7
	>=dev-db/sqlite-3.4
	>=dev-libs/openssl-1.0.0
	>=dev-cpp/yaml-cpp-0.2.5
	>=sci-physics/bullet-2.79
	<sci-physics/bullet-2.81
	sys-libs/libtermcap-compat
	"

DEPEND_FAWKES="
	>=dev-cpp/libxmlpp-2.20.0
	>=net-libs/libmicrohttpd-0.9.6[messages]
	>=dev-libs/libdaemon-0.14
	>=app-text/asciidoc-8.4
	>=app-doc/doxygen-1.7.2
	>=dev-cpp/gtkmm-2.12
	>=dev-cpp/glibmm-2.14
	>=dev-cpp/cairomm-1.4.4
	>=dev-cpp/libglademm-2.6.4
	"
DEPEND_BEHAVIOR="
	>=dev-lang/lua-5.1
	>=dev-lua/toluapp-1.0.93
	"
DEPEND_SKILLER="
	>=media-gfx/graphviz-2.22
	"
DEPEND_RRD="
	>=net-analyzer/rrdtool-1.4
	"
DEPEND_FIREVISION="
	>=media-libs/libdc1394-2.1.0
	>=media-libs/libsdl-1.2.13
	virtual/jpeg
	>=media-libs/libpng-1.2.22
	>=media-libs/opencv-1.0.0
	"
RDEPEND=$DEPEND_ALL_REQ$DEPEND_FAWKES$DEPEND_BEHAVIOR$DEPEND_SKILLER$DEPEND_RRD$DEPEND_FIREVISION

userhome=$(egethome 1000)

# add fawkes group for path
pkg_setup() {
	enewgroup fawkes
}

# message to inform user about fawkes grou
pkg_postinst() {
	elog "add yourself to the fawkes group to have the ${userhome}/fawkes-robotino/bin in your path"
}

# install the path file
src_install(){
	echo "PATH=\"${userhome}/fawkes-robotino/bin\"" > ${T}/80${PN} || die "can't echo path"
	doenvd ${T}/80${PN}
	dosym ../usr/lib/libtermcap.so.2 ${ROOT}/lib/libtermcap.so
}

src_unpack() {
	mkdir -p ${WORKDIR}/${P} || die "coud not create ${WORKDIR}/${P}"
	#touch ${T}/80{$PN}
}