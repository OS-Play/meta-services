FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://bluez5.cfg"

inherit openrc-run

do_install:append() {
    install -d ${D}${sysconfdir}/conf.d/
    install -m0644 -D ${WORKDIR}/bluez5.cfg ${D}${sysconfdir}/conf.d/bluetooth

    sed -i -e 's#@LIBEXECDIR@#${libexecdir}#g' ${D}${sysconfdir}/conf.d/bluetooth
}

RC_INITSCRIPT_NAME = "bluetooth"
RC_INITSCRIPT_PARAMS = "default"
