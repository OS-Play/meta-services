FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit openrc-run

RC_INITSCRIPT_NAME = "udev"
RC_INITSCRIPT_PARAMS = "default"

