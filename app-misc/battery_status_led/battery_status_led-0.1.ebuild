# Copyright 2018 Denes Matetelki
# Distributed under the terms of the GNU General Public License v3

EAPI=6

#inherit git-r3 systemd linux-info
inherit git-r3 systemd


DESCRIPTION="Battery (low/critical) status indication by making a (the capslock) LED blink"
HOMEPAGE="https://github.com/dmatetelki/battery_status_led"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dmatetelki/battery_status_led"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#CONFIG_CHECK="CONFIG_X86_PLATFORM_DEVICES"

#pkg_setup {
#	linux-info_pkg_setup
#}

DOCS="README.md"

src_install() {
	dodoc ${DOCS}
	dobin battery_status_led.sh
	systemd_dounit battery_status_led.service
}

pkg_postinst() {
	elog "Make sure you have your laptop's ACPI module compiled into your kernel:"
	elog "Device Drivers > X86 Platform Specific Device Drivers"
	elog "For example: Asus laptop extras, ThinkPad ACPI Laptop Extras, etc."
	elog "You can specify which LED device to use by editing the service file."
}
