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
Usage: $name <board> <subtarget> <pattern>

Example:
	$name ar71xx generic "gl-"
EOF

	exit 1
}

[ $# -ne 3 ] && usage

BOARD=$1
SUBTARGET=$2
PATTERN=$3

# Execute makefile
MAKE=$(make -C target/linux/$BOARD --no-print-directory DUMP=1 TARGET_BUILD=1 SUBTARGET=$SUBTARGET V=s)

# Match profiles
cat <<-EOF | grep -iE "^(Target-Profile: DEVICE_$PATTERN)" | sed 's/Target-Profile: DEVICE_//'
	$MAKE
EOF
