#!/bin/bash

. version.sh

VERSION=$KERNEL_FULL_VER

PACKAGE_NAME="linux-kernel-boot"
DESCRIPTION="Linux kernel uboot installation metapackage (Ninja Blocks BBB compatible)"
ARCH="armhf"
REVISION="1"
PACKAGE_VERSION="${VERSION}-${REVISION}_${ARCH}"
FULL_PACKAGE_NAME="${PACKAGE_NAME}_${PACKAGE_VERSION}.deb"

echo "Creating kernel boot metapackage for $KERNEL_FULL_VER"

mkdir -p tmp/
rm -rf tmp/$FULL_PACKAGE_NAME

echo "Creating the package ${FULL_PACKAGE_NAME}"

fpm -s empty -t deb \
-n ${PACKAGE_NAME} -v ${VERSION}-${REVISION} \
--deb-compression xz --deb-user root --deb-group root \
-m "Builder <builder@ninjablocks.com>" --url http://ninjablocks.com/ \
--description "${DESCRIPTION}" -a $ARCH \
-p tmp/${FULL_PACKAGE_NAME} \
-d "linux-kernel-${VERSION}" \
--template-scripts \
--after-install kernel-postinstall
