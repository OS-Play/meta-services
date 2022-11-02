FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://dbus.cfg \
            file://dbus.rc"

inherit openrc-run

do_install:append() {
    install -d ${D}${sysconfdir}/conf.d/
    install -m0644 -D ${WORKDIR}/dbus.cfg ${D}${sysconfdir}/conf.d/dbus

    if ${@bb.utils.contains('DISTRO_FEATURES', 'openrc', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/init.d
        install -m 0755 ${WORKDIR}/dbus.rc ${D}${sysconfdir}/init.d/dbus
        install -d ${D}${sysconfdir}/default/volatiles
        echo "d messagebus messagebus 0755 ${localstatedir}/run/dbus none" \
             > ${D}${sysconfdir}/default/volatiles/99_dbus
    fi
}

RC_INITSCRIPT_NAME = "dbus"
RC_INITSCRIPT_PARAMS = "default"
