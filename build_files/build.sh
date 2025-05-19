#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:

dnf install -y 'dnf-command(config-manager)' epel-release
dnf config-manager --add-repo https://repo.secureblue.dev/secureblue.repo
dnf config-manager --set-enabled crb

# this installs a package from fedora repos
dnf update -y
dnf install -y trivalent distrobox
dnf -y groupinstall "KDE Plasma Workspaces" "base-x"

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/secureblue.repo

systemctl enable sddm.service

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf config-manager --set-disabled https://repo.secureblue.dev/secureblue.repo

#### Example for enabling a System Unit File

dnf config-manager --add-repo repository

