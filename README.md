# battery_status_led
Battery (low/critical) status indication by making a (the capslock) LED blink

Make sure you have your laptop's ACPI module compiled into your kernel:
Device Drivers > X86 Platform Specific Device Drivers
For example: Asus laptop extras, ThinkPad ACPI Laptop Extras, etc.

Start it as root user:
/usr/bin/battery_status_led.sh

Or with systemd:
systemctl start battery_status_led
systemctl enable battery_status_led

The LED device can be changed by editing the systemd service file's line:
Environment="BATTERY_STATUS_LED_DEV=/sys/class/leds/input4\:\:capslock"

Manual install on gentoo:
cd DIR
git clone https://github.com/dmatetelki/battery_status_led
cd /usr/local/portage/app-misc/
ln -s DIR/battery_status_led/app-misc/battery_status_led  battery_status_led
ebuild battery_status_led-0.1.ebuild digest
emerge battery_status_led
