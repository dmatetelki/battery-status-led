#!/bin/bash

# Copyright 2018 Denes Matetelki

# This file is part of battery_status_led.

# battery_status_led is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License v3 as published by the Free
# Software Foundation.

# battery_status_led is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License v3 for
# more details.

# You should have received a copy of the GNU General Public License v3 along
# with battery_status_led. If not, see
# https://www.gnu.org/licenses/gpl-3.0.html.

VERSION="0.1-1"
rm -rf build*

mkdir -p build/batterystatusled_${VERSION}/DEBIAN
# cp control build/batterystatusled_${VERSION}/DEBIAN/control

cat > build/batterystatusled_${VERSION}/DEBIAN/control <<EOL
Package: batterystatusled
Version: ${VERSION}
Section: base
Priority: optional
Architecture: amd64
Maintainer: Denes Matetelki <denes.matetelki@gmail.com>
Description: Battery Status LED
  Battery (low/critical) status indication by making a (the capslock) LED blink"
EOL

mkdir -p build/batterystatusled_${VERSION}/lib/systemd/system
cp ../battery_status_led.service build/batterystatusled_${VERSION}/lib/systemd/system

mkdir -p build/batterystatusled_${VERSION}/usr/bin
cp ../battery_status_led.sh build/batterystatusled_${VERSION}/usr/bin

mkdir -p build/batterystatusled_${VERSION}/usr/share/doc/
cp ../README.md build/batterystatusled_${VERSION}/usr/share/doc/

cd build
dpkg-deb --build batterystatusled_${VERSION}

cd ..
mv build/batterystatusled_${VERSION}.deb .
rm -rf build