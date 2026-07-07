#!/bin/bash
# One-shot audio setup for iMac 18,2 (2017 21.5" 4K) on Ubuntu 24.04 with HWE kernel
# Installs the patched CS8409 driver that initializes the TAS5764L speaker amplifiers.
#
# Usage: sudo ./setup-imac18-2.sh
# After running, reboot for changes to take effect.

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo ./setup-imac18-2.sh"
    exit 1
fi

UNAME=$(uname -r)
echo "Kernel: $UNAME"

# Install dependencies
apt install -y dkms linux-headers-$UNAME

# Remove any stale modprobe overrides from previous attempts
rm -f /etc/modprobe.d/snd-hda-intel-cs8409.conf

# Build and install the patched module
./install.cirrus.driver.sh

echo ""
echo "Done. Reboot now for audio to work:"
echo "  sudo reboot"
