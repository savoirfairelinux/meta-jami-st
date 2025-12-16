FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
        file://jami-client.service \
        file://0001-cmake-add-option-to-disable-libx11-dependency.patch \
        file://0002-Patch-removed-reference-to-Gsettings.patch \
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
}

FILES:${PN}:append = " ${systemd_system_unitdir}/jami-client.service"

SYSTEMD_SERVICE:${PN} = "jami-client.service"
