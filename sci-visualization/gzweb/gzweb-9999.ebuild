# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mercurial cmake-utils

DESCRIPTION="Gazebo server webview"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="fawkes-models"

DEPEND="dev-vcs/mercurial
		dev-libs/jansson
		net-libs/nodejs[npm]
		dev-libs/boost
		media-gfx/imagemagick
		dev-libs/tinyxml
		sci-visualization/gazebo
		dev-libs/libpthread-stubs
		fawkes-models? ( dev-vcs/git )"
RDEPEND="${DEPEND}"

EHG_REPO_URI=https://bitbucket.org/osrf/gzweb


CMAKE_IN_SOURCE_BUILD=true
MODEL_DIR=models
MODEL_SRC_DIR=${EHG_STORE_DIR}/${EHG_PROJECT}/${MODEL_DIR}
MODEL_SRC_URI=https://bitbucket.org/osrf/gazebo_models

FAWKES_MODEL_DIR=fawkes-models
FAWKES_MODEL_SRC_URI=http://git.fawkesrobotics.org/gazebo-models.git
FAWKES_MODEL_SRC_DIR=${EHG_STORE_DIR}/${EHG_PROJECT}/${FAWKES_MODEL_DIR}

src_unpack() {
	#fetch sources
	mercurial_fetch

	#fetch additional sources
	#gazebo models
	if [[ ! -d "${MODEL_SRC_DIR}" ]] ; then
		einfo "Cloning ${MODEL_SRC_URI} to ${MODEL_SRC_DIR}"
		${EHG_CLONE_CMD} "${MODEL_SRC_URI}" "${MODEL_SRC_DIR}" || {
			rm -rf "${MODEL_SRC_DIR}"
			die "failed to clone ${MODEL_SRC_URI}"
		}
		cd "${MODEL_SRC_DIR}"
	elif [[ -z "${EHG_OFFLINE}" ]]; then
		einfo "Updating ${MODEL_SRC_DIR} from ${MODEL_SRC_URI}"
		cd "${MODEL_SRC_DIR}" || die "failed to cd to ${MODEL_SRC_DIR}"
		${EHG_PULL_CMD} "${MODULE_SRC_URI}" || die "update failed"
	fi
	einfo "Model directory: ${WORKDIR}/${MODEL_DIR}"
	hg clone ${EHG_QUIET_CMD_OPT} "${MODEL_SRC_DIR}" "${WORKDIR}/${MODEL_DIR}" || die clone failed

	#fetch fawkes models
	if use fawkes-models ; then
		if [[ ! -d ${FAWKES_MODEL_SRC_DIR} ]]; then
			einfo "fetching fawkes models via git from ${FAWKES_MODEL_SRC_URI} into ${FAWKES_MODEL_SRC_DIR}"
			git clone "${FAWKES_MODEL_SRC_URI}" "${FAWKES_MODEL_SRC_DIR}" || die
		else
			einfo "updating git in ${FAWKES_MODEL_SRC_DIR}"
			cd "${FAWKES_MODEL_SRC_DIR}" || die
			git pull || die
		fi
		git clone "${FAWKES_MODEL_SRC_DIR}" "${WORKDIR}/${FAWKES_MODEL_DIR}" || die
	fi
}

src_prepare() {
	epatch ${FILESDIR}/*.patch
	npm install
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	#compile normal src
	cmake-utils_src_compile
	
	einfo "configure and build node-gyp"
	cd ${S}/gzbridge || die
	${S}/node_modules/.bin/node-gyp configure --python python2 || die
	${S}/node_modules/.bin/node-gyp build -d || die
	cd ${S} || die
	
	einfo "gyp built"

	einfo "merging models"
	
	cd ${WORKDIR}/${MODEL_DIR} || die
	mkdir build || die
	cd build || die
	cmake .. -DCMAKE_INSTALL_PREFIX=${S}/http/client || die
	make install > /dev/null 2>&1 || die
	cd ${S} || die
	rm -rf ${S}/http/client/assets || die
	mv ${S}/http/client/models ${S}/http/client/assets || die
	if use fawkes-models ; then
		einfo merging fawkes models
		cp -r ${WORKDIR}/${FAWKES_MODEL_DIR}/* "${S}/http/client/assets/" || die
	fi

	${S}/get_local_models.py ${S}/http/client/assets || die
	${S}/webify_models_v2.py ${S}/http/client/assets || die


	elog "please run gzthumbnails.sh to greate thumbnails"

	einfo "models merged"

}

src_install() {
	#install files
	mkdir -p ${D}/usr/share/gzweb
	cp -a coarse_meshes.sh get_local_models.py gz3d gzbridge http node_modules package.json start_gzweb.sh stop_gzweb.sh tools webify_models_v2.py ${D}/usr/share/gzweb
	#strip cmake files
	find ${D} -iname '*cmake*' -exec rm -rf {} +
	#strip makefiles
	find ${D} -name "*Makefile*" -delete
	#strip src dirs
	find ${D} "(" -name "src" ")" -exec rm -rf {} + 
	#strip cc and hpp files
	find ${D} "(" -name '*.cpp' -or -name '*.hpp' -or -name '*.cc' -or -name '*.hh' ")" -delete
	#strip readmes
	find ${D} -iname "*readme*" -delete
	#create symlinks for bins
	mkdir -p ${D}/usr/bin
	for binary in get_local_models.py start_gzweb.sh stop_gzweb.sh webify_models_v2.py tools/gzthumbnails.sh; do
		ln -s /usr/share/gzweb/${binary} ${D}/usr/bin/$(basename ${binary})
	done

}
