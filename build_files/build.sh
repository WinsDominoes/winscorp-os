#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:

dnf install -y 'dnf-command(config-manager)' epel-release
dnf config-manager --add-repo https://repo.secureblue.dev/secureblue.repo
dnf config-manager --set-enabled crb
dnf -y copr enable ublue-os/packages
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/rhel/10/tailscale.repo

# this installs a package from fedora repos
dnf update -y
dnf install -y trivalent distrobox plasma-desktop sddm dolphin flatpak plasma-discover ublue-os-just ublue-os-luks ublue-os-signing ublue-os-udev-rules ublue-os-update-services ublue-brew ublue-setup-services ublue-polkit-rules uupd tailscale cockpit ptyxis gcc

# CrossOver Custom RPM
dnf install -y http://crossover.codeweavers.com/redirect/crossover.rpm --nobest

# Remove packages
dnf remove -y xwaylandvideobridge PackageKit

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/secureblue.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo
dnf -y copr disable ublue-os/packages

systemctl enable sddm.service
systemctl enable brew-setup.service
systemctl enable tailscaled.service
systemctl enable fwupd.service
systemctl enable ublue-system-setup.service
systemctl --global enable ublue-user-setup.service
systemctl enable uupd.timer
systemctl enable cockpit.socket

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


#### Example for enabling a System Unit File



