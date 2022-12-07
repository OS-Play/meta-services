FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append() {
    sed -i -e "s:@sbindir@:${sbindir}:g" ${D}${sysconfdir}/init.d/sshd
}


inherit openrc-run

RCUPDATEPN = "openssh-sshd"
RC_INITSCRIPT_NAME = "sshd"
RC_INITSCRIPT_PARAMS = "default"
