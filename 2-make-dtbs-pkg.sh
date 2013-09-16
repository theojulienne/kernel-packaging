#!/bin/bash

. version.sh

VERSION=$KERNEL_FULL_VER

PACKAGE_NAME="linux-dtbs-${VERSION}"
DESCRIPTION="Linux kernel DTBS files (Ninja Blocks BBB compatible)"
ARCH="armhf"
REVISION="1"
PACKAGE_VERSION="1.0cross"
FULL_PACKAGE_NAME="${PACKAGE_NAME}_${PACKAGE_VERSION}_${ARCH}.deb"

echo "Packaging DTBS for $KERNEL_FULL_VER"

ls -la linux-dev/deploy/$KERNEL_FULL_VER-dtbs.tar.gz

rm -rf tmp-$KERNEL_FULL_VER-dtbs
mkdir -p tmp-$KERNEL_FULL_VER-dtbs
mkdir -p tmp-$KERNEL_FULL_VER-dtbs/boot/dtbs-$KERNEL_FULL_VER

# extracts the default dtbs files from the kernel
tar zxvf linux-dev/deploy/$KERNEL_FULL_VER-dtbs.tar.gz -C tmp-$KERNEL_FULL_VER-dtbs/boot/dtbs-$KERNEL_FULL_VER

# grab the patched dtc tool
if [ -d ./dtc ] ; then
	cd dtc
	git pull
else
	git clone https://github.com/theojulienne/dtc.git
	cd dtc
fi

# compile dtc
make
cd .. # back out of dtc

# pull down and patch the ninjablocks bbb dtbs override
if [ -d ./ninjablocks-bbb-dts ] ; then
	cd ninjablocks-bbb-dts
	git pull
else
	git clone https://github.com/wolfeidau/ninjablocks-bbb-dts.git
	cd ninjablocks-bbb-dts
fi

#bash make.sh
../dtc/dtc -O dtb -o am335x-boneblack.dtb -b 0 -@ am335x-boneblack.dts

cd .. # back out of the ninjablocks-bbb-dts dir

# actually copy the new file in!
ls -la
cp ninjablocks-bbb-dts/am335x-boneblack.dtb tmp-$KERNEL_FULL_VER-dtbs/boot/dtbs-$KERNEL_FULL_VER
ls -la

# we now have a tree, make the package!
echo "Creating the package ${FULL_PACKAGE_NAME}"
fpm -s dir -t deb \
-n ${PACKAGE_NAME} -v ${PACKAGE_VERSION} \
--deb-compression xz --deb-user root --deb-group root \
-m "Builder <builder@ninjablocks.com>" --url http://ninjablocks.com/ \
--description "${DESCRIPTION}" -C tmp-$KERNEL_FULL_VER-dtbs -a $ARCH \
-p tmp-$KERNEL_FULL_VER-dtbs/${FULL_PACKAGE_NAME} boot/
