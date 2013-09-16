#!/bin/bash

. version.sh

VERSION=$KERNEL_FULL_VER

PACKAGE_NAME="linux-kernel-${VERSION}"
DESCRIPTION="Linux kernel metapackage (Ninja Blocks BBB compatible)"
ARCH="armhf"
REVISION="1"
PACKAGE_VERSION="1.0cross"
FULL_PACKAGE_NAME="${PACKAGE_NAME}_${PACKAGE_VERSION}_${ARCH}.deb"

echo "Creating kernel metapackage for $KERNEL_FULL_VER"

mkdir -p tmp/
rm -rf tmp/$FULL_PACKAGE_NAME

echo "Creating the package ${FULL_PACKAGE_NAME}"

fpm -s empty -t deb \
-n ${PACKAGE_NAME} -v ${PACKAGE_VERSION} \
--deb-compression xz --deb-user root --deb-group root \
-m "Builder <builder@ninjablocks.com>" --url http://ninjablocks.com/ \
--description "${DESCRIPTION}" -a $ARCH \
-p tmp/${FULL_PACKAGE_NAME} \
-d "linux-image-${VERSION}" \
-d "linux-dtbs-${VERSION}" \
-d "linux-firmware-dtbo-${VERSION}"
