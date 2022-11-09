FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://adbd-init"

do_install:append() {
    # we don't need the systemd service
    rm -rf ${D}${nonarch_base_libdir}/

    # cleanup at adbd stop in rc script
    rm -f ${D}${bindir}/android-gadget-cleanup

    install -d ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/adbd-init ${D}${sysconfdir}/init.d/adbd
}

inherit openrc-run

RC_INITSCRIPT_NAME = "adbd"
RC_INITSCRIPT_PARAMS = "default"
