#!/bin/sh

set -u
set -e

CONFIGFS="configfs	/sys/kernel/config	configfs	defaults	0	0"
FSTAB="${TARGET_DIR}/etc/fstab"

# Add configfs to fstab
if ! grep -xq "$CONFIGFS" "$FSTAB"; then
	echo "$CONFIGFS" >> "$FSTAB"
fi
