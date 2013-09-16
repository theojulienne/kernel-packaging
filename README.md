kernel-packaging
================

Debian packages for the Linux kernel, for use on the Beagle Bone Black. Designed for a patch supporting the rtl8192 
wifi chipset (in a separate repo, linux-dev)

Currently downloads and packages the 3.8 branch of the Linux kernel from https://github.com/theojulienne/linux-dev

Run all shell scripts in order (0-6), a final set of kernels will be available in the "dist" folder.

The kernel version used is defined in `1-build-kernel.sh`, the version details from the chosen linux-dev branch will
be used as the versioning for all kernel packages.

The build system is based on Robert Nelson's kernel build scripts and install scripts, but packages everything
completely inside .deb packages.

These packages work by taking the initial packages from linux-dev:
* linux-headers
* linux-image

And creating new packages for the required parts of the firmware and dtbs gzip files from linux-dev:
* linux-dtbs (from the "-dtbs.tar.gz")
* linux-firmware-dtbo (from the "-firmware.tar.gz")

Then finally creates some metapackages:
* linux-kernel (simply requires linux-image, linux-dtbs and linux-firmware-dtbo above)
* linux-kernel-boot (requires linux-kernel and installs the kernel in such a way that uboot will boot it, similar to `install-me.sh`)

