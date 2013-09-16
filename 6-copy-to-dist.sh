# copy these files to dist:
#   linux-headers-XX
#   linux-image-XX
#   linux-dtbs-XX
#   linux-firmware-dtbo-XX
#   linux-kernel-XX
#   linux-kernel-boot-XX

mkdir -p dist

. version.sh

cp linux-dev/deploy/linux-headers-${KERNEL_FULL_VER}_1.0cross_armhf.deb dist/
cp linux-dev/deploy/linux-image-${KERNEL_FULL_VER}_1.0cross_armhf.deb dist/
cp tmp-$KERNEL_FULL_VER-dtbs/linux-dtbs-${KERNEL_FULL_VER}_1.0cross_armhf.deb dist/
cp tmp-$KERNEL_FULL_VER-firmware/linux-firmware-dtbo-${KERNEL_FULL_VER}_1.0cross_armhf.deb dist/
cp tmp/linux-kernel-${KERNEL_FULL_VER}_1.0cross_armhf.deb dist/
cp tmp/linux-kernel-boot_${KERNEL_FULL_VER}-1_armhf.deb dist/
