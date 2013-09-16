#!/bin/bash

. version.sh

VERSION=$KERNEL_FULL_VER

PACKAGE_NAME="linux-firmware-dtbo-${VERSION}"
DESCRIPTION="Linux kernel DTBO firmware files (Ninja Blocks BBB compatible)"
ARCH="armhf"
REVISION="1"
PACKAGE_VERSION="1.0cross"
FULL_PACKAGE_NAME="${PACKAGE_NAME}_${PACKAGE_VERSION}_${ARCH}.deb"

echo "Packaging DTBO firmware for $KERNEL_FULL_VER"

ls -la linux-dev/deploy/$KERNEL_FULL_VER-firmware.tar.gz

rm -rf tmp-$KERNEL_FULL_VER-firmware
mkdir -p tmp-$KERNEL_FULL_VER-firmware
mkdir -p tmp-$KERNEL_FULL_VER-firmware/lib/firmware-$KERNEL_FULL_VER

# extracts the default firmware files from the kernel
tar zxvf linux-dev/deploy/$KERNEL_FULL_VER-firmware.tar.gz -C tmp-$KERNEL_FULL_VER-firmware/lib/firmware-$KERNEL_FULL_VER

# we now have a tree, make the package!
echo "Creating the package ${FULL_PACKAGE_NAME}"
fpm -s dir -t deb \
-n ${PACKAGE_NAME} -v ${PACKAGE_VERSION} \
--deb-compression xz --deb-user root --deb-group root \
-m "Builder <builder@ninjablocks.com>" --url http://ninjablocks.com/ \
--description "${DESCRIPTION}" -C tmp-$KERNEL_FULL_VER-firmware -a $ARCH \
-p tmp-$KERNEL_FULL_VER-firmware/${FULL_PACKAGE_NAME} lib/
