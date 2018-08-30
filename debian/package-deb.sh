#!/bin/bash

# Copyright 2018 Denes Matetelki

# This file is part of battery-status-led.

# battery-status-led is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License v3 as published by the Free
# Software Foundation.

# battery-status-led is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License v3 for
# more details.

# You should have received a copy of the GNU General Public License v3 along
# with battery-status-led. If not, see
# https://www.gnu.org/licenses/gpl-3.0.html.

NAME="battery-status-led"
VERSION="0.1-1"

rm -rf build*
mkdir -p build/${NAME}_${VERSION}/DEBIAN

cat > build/${NAME}_${VERSION}/DEBIAN/control <<EOL
Package: ${NAME}
Version: ${VERSION}
Section: misc
Priority: optional
Architecture: amd64
Maintainer: Denes Matetelki <denes.matetelki@gmail.com>
Description: Battery Status LED
  Battery (low/critical) status indication by making a (the capslock) LED blink"
EOL

mkdir -p build/${NAME}_${VERSION}/lib/systemd/system
cp ../${NAME}.service build/${NAME}_${VERSION}/lib/systemd/system/

mkdir -p build/${NAME}_${VERSION}/usr/bin
cp ../${NAME} build/${NAME}_${VERSION}/usr/bin/

mkdir -p build/${NAME}_${VERSION}/usr/share/doc/${NAME}
cp ../README.md build/${NAME}_${VERSION}/usr/share/doc/${NAME}/

mkdir -p build/${NAME}_${VERSION}/usr/share/man/man1
cp ../${NAME}.1 build/${NAME}_${VERSION}/usr/share/man/man1/
bzip2 build/${NAME}_${VERSION}/usr/share/man/man1/${NAME}.1

cd build
dpkg-deb --root-owner-group --build ${NAME}_${VERSION}

cd ..
mv build/${NAME}_${VERSION}.deb .
rm -rf build

