FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://alsactl-init"

RDEPENDS:alsa-utils-alsactl += "openrc"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -D -m0755 ${WORKDIR}/alsactl-init ${D}${sysconfdir}/init.d/alsa-state
    sed -i -e "s:@sbindir@:${sbindir}:g" ${D}${sysconfdir}/init.d/alsa-state
}

FILES:alsa-utils-alsactl += "${sysconfdir}/init.d/"

inherit openrc-run

RCUPDATEPN = "alsa-utils-alsactl"
RC_INITSCRIPT_NAME = "alsa-state"
RC_INITSCRIPT_PARAMS = "default"
