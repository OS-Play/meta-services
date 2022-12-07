SUMMARY = "Early OOM Daemon for Linux."
DESCRIPTION = "The oom-killer generally has a bad reputation among Linux users. \
                This may be part of the reason Linux invokes it only when it has \
                absolutely no other choice. It will swap out the desktop environment, \
                drop the whole page cache and empty every buffer before it will \
                ultimately kill a process. At least that's what I think that it will \
                do. I have yet to be patient enough to wait for it, sitting in front \
                of an unresponsive system.."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=875c33872f2633c48ce20e87d8cd3270"

SRC_URI = "gitsm://github.com/rfjakob/earlyoom.git;protocol=https;branch=master \
           file://openrc-init \
           file://earlyoom.cfg \
           "
S = "${WORKDIR}/git"

PV = "1.7"
SRCREV = "ebaea9526bcee14889b00d83a9dd3d038315cee2"

inherit pkgconfig openrc-run

do_compile() {
    oe_runmake
}

do_install() {
    DESTDIR=${D} PREFIX=${prefix} oe_runmake install-bin install-default

    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${sysconfdir}/conf.d
    install -D -m0755 ${WORKDIR}/openrc-init ${D}${sysconfdir}/init.d/earlyoom
    install -D -m0644 ${WORKDIR}/earlyoom.cfg ${D}${sysconfdir}/conf.d/earlyoom
    sed -i -e "s:@sbindir@:${sbindir}:g" ${D}${sysconfdir}/init.d/earlyoom
}

FILES:${PN} = "${bindir}/earlyoom \
                ${sysconfdir}/init.d/earlyoom \
                ${sysconfdir}/conf.d/earlyoom \
                ${sysconfdir}/default/earlyoom"

RC_INITSCRIPT_NAME = "earlyoom"
RC_INITSCRIPT_PARAMS = "default"
