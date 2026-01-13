FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
        file://jami-client.service \
        file://0001-cmake-add-option-to-disable-libx11-dependency.patch \
        file://0002-Patch-removed-reference-to-Gsettings.patch \
        file://jami-client-kms.config \
"

inherit useradd systemd

USERADD_PACKAGES = "${PN}"
USERADD_PARAM:${PN} = " \
        --groups input,video,audio \
        --user-group \
        --create-home \
        -c 'Jami user' \
        -s /bin/false \
        -U \
        -r \
        jami \
        "

do_install:append() {
        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/jami-client.service ${D}/${systemd_system_unitdir}/

        install -d ${D}${sysconfdir}
        install -m 0644 ${WORKDIR}/jami-client-kms.config ${D}${sysconfdir}/jami-client-kms.config
}

FILES:${PN}:append = " \
    ${systemd_system_unitdir}/jami-client.service \
    ${sysconfdir}/jami-client-kms.config \
"

SYSTEMD_SERVICE:${PN} = "jami-client.service"
