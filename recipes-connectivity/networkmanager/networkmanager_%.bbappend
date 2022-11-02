FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://networkmanager.cfg"

inherit openrc-run

do_install:append() {
    install -d ${D}${sysconfdir}/conf.d/
    install -m0644 -D ${WORKDIR}/networkmanager.cfg ${D}${sysconfdir}/conf.d/network-manager
}

RC_INITSCRIPT_NAME = "network-manager"
RC_INITSCRIPT_PARAMS = "default"


