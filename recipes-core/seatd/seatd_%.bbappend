FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit openrc-run

RC_INITSCRIPT_NAME = "seatd"
RC_INITSCRIPT_PARAMS = "default"
