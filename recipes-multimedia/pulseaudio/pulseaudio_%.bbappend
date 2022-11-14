FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://pulse.sh \
            file://pulseaudio-server-init \
            file://pulseaudio-server-cfg \
            "

do_install:append() {
    install -d ${D}${sysconfdir}/init.d/
    install -d ${D}${sysconfdir}/profile.d
    install -d ${D}${sysconfdir}/conf.d

    install -D -m0644 ${WORKDIR}/pulse.sh ${D}${sysconfdir}/profile.d/pulse.sh
    install -D -m0755 ${WORKDIR}/pulseaudio-server-init ${D}${sysconfdir}/init.d/pulseaudio-server
    install -D -m0755 ${WORKDIR}/pulseaudio-server-cfg ${D}${sysconfdir}/conf.d/pulseaudio-server

    sed -i -e "s:@sbindir@:${sbindir}:g" ${D}${sysconfdir}/init.d/pulseaudio-server
}

FILES:${PN}-server += "${sysconfdir}/profile.d/pulse.sh \
        ${sysconfdir}/init.d/pulseaudio-server \
        ${sysconfdir}/conf.d/pulseaudio-server"

inherit openrc-run

RCUPDATEPN = "${PN}-server"
RC_INITSCRIPT_NAME = "pulseaudio-server"
RC_INITSCRIPT_PARAMS = "default"
