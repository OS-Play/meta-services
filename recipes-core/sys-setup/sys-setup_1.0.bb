SUMMARY = "Play OS extra init scripts"
DESCRIPTION = "Extra OpenRC init scripts for Play OS."
HOMEPAGE = "https://github.com/OS-Play"
SECTION = "base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://scripts/"

INSTALL_SCRIPTS = "mount-configfs \
           "

RDEPENDS:${PN} += "openrc"

enable_script() {
    ln -sf ${sysconfdir}/init.d/$1 ${D}${sysconfdir}/runlevels/$2
}

do_install() {
    install -d ${D}${sysconfdir}/init.d

    install -d ${D}${sysconfdir}/runlevels/boot
    install -d ${D}${sysconfdir}/runlevels/default
    install -d ${D}${sysconfdir}/runlevels/nonetwork
    install -d ${D}${sysconfdir}/runlevels/shutdown
    install -d ${D}${sysconfdir}/runlevels/sysinit

    for s in ${INSTALL_SCRIPTS}; do
        install -D -m0755 ${WORKDIR}/scripts/$s ${D}${sysconfdir}/init.d/$s
        sed -i -e "s:@sbindir@:${sbindir}:g" ${D}${sysconfdir}/init.d/$s
    done

    enable_script mount-configfs boot
}

FILES:${PN} += "${sysconfdir}/"
