#!/usr/bin/env bash

export TOPDIR=$PWD
# make -C target/linux/ar71xx install TARGET_BUILD=1 V=s
# make -C target/linux/ar71xx compile TARGET_BUILD=1 V=s
# make -C target/linux/ar71xx/image compile TARGET_BUILD=1 PROFILE="gl-ar300m"
# make -C target/linux/ar71xx/image install TARGET_BUILD=1 DUMP=1
# make -C target/linux/ar71xx/image install TARGET_BUILD=1 IB=1 PROFILE="gl-ar150"
# make -C target/linux/ar71xx/image install TARGET_BUILD=1 IB=1 PROFILE="GL AR300M"

usage() {
	local name=${0##*/}

	cat <<EOF
Usage: $name [option]

Valid options are:

	-b <board>:		Specified board infomation
	-p <profile>:	Specified target to build
	-i <packages>:	Specified packages install to rootfs
	-r <packages>:	Specified packages remove from rootfs
	-h:				Show this help message and exit

For example:
	$name -b ar71xx -p "gl-ar150" -i "kmod-ath9k" -r "luci uhttpd"
EOF

	exit 1
}

while getopts "b:p:i:r:h" arg; do
	case "$arg" in
		b)
			BOARD=$OPTARG
			;;
		p)
			PROFILE=$OPTARG
			;;
		i)
			INSTALL_PKGS=$OPTARG
			;;
		r)
			REMOVE_PKGS=$OPTARG
			;;
		*|h)
			usage
			;;
	esac
done

[ -z "$PROFILE" -o -z "$BOARD" ] && usage

# Make image
make package/install PACKAGES="$INSTALL_PKGS" PACKAGES_REMOVE="$REMOVE_PKGS" V=s
make -C target/linux/$BOARD/image install TARGET_BUILD=1 IB=1 PROFILE="$PROFILE" V=s
