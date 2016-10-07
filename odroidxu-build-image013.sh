#!/bin/sh

########################################################################
# odroidxu-build-image
# Copyright (C) 2015 Ryan Finnie <ryan@finnie.org>
# Copyright (C) 2015 Luca Falavigna <dktrkranz@debian.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
########################################################################
# Copyright (C) 2015 Krzysztof Sadowski <szakan@gmail.com>

set -e
set -e
set -x

RELEASE=jessie
BASEDIR=odroidxu/${RELEASE}
BUILDDIR=${BASEDIR}/build
K_VERSION=3.4.104
# Don't clobber an old build
if [ -e "$BUILDDIR" ]; then
  echo "$BUILDDIR exists, not proceeding"
  exit 1
fi

# Set up environment
export TZ=CET
R=${BUILDDIR}/chroot
mkdir -p $R

# Install dependencies
apt-get -y install debootstrap qemu-user-static dosfstools rsync bmap-tools

# Base debootstrap
debootstrap --arch=armhf --foreign --include=apt-transport-https,ca-certificates $RELEASE $R ftp://ftp.debian.org/debian
cp /usr/bin/qemu-arm-static $R/usr/bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R /debootstrap/debootstrap --second-stage --arch=armhf

# Mount required filesystems
mount -t proc none $R/proc
mount -t sysfs none $R/sys

# Set up initial sources.list
cat <<EOM >$R/etc/apt/sources.list
deb http://ftp.debian.org/debian ${RELEASE} main contrib non-free
deb-src http://ftp.debian.org/debian ${RELEASE} main contrib non-free

deb http://ftp.debian.org/debian/ ${RELEASE}-updates main contrib non-free
deb-src http://ftp.debian.org/debian/ ${RELEASE}-updates main contrib non-free

deb http://security.debian.org/ ${RELEASE}/updates main contrib non-free
deb-src http://security.debian.org/ ${RELEASE}/updates main contrib non-free

EOM

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get update
#LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get  dist-upgrade
#LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ dpkg-reconfigure locales
#LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ locale-gen pl_PL
#LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ locale-gen pl_PL.UTF-8
##########################################################################
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install accountsservice
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install acl
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install adduser
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install adwaita-icon-theme
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aisleriot

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install alsa-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install alsa-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install anacron

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install apg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install apt

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install apt-listchanges

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install apt-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aptitude

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aptitude-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aptitude-doc-en

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aspell

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install aspell-en

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install at

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install autopoint

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install avahi-autoipd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install avahi-daemon

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install base-files

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install base-passwd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bash

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bash-completion

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bind9-host

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install binutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bluetooth

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bluez

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bluez-obexd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install brasero

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install brasero-cdrkit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install brasero-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bsd-mailx

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bsdmainutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bsdutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install busybox

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install bzip2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ca-certificates

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install caribou

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cdrdao

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cheese

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cheese-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-control-center

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-control-center-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-desktop-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-desktop-environment

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-l10n

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-screensaver

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-session

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-session-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cinnamon-settings-daemon

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cjs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libcbc3

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libcgl1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libclp1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libcoinmp1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libcoinutils3

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coinor-libosi1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install colord

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install colord-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install coreutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cpio

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cpp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cracklib-runtime

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install crda

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cron

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-browsed

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-bsd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-client

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-core-drivers

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-daemon

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-filters

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-filters-core-drivers

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-pk-helper

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-ppdc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install cups-server-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dash

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dbus

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dbus-x11

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dconf-gsettings-backend

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dconf-service

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debconf

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debconf-i18n

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debian-archive-keyring

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debian-faq

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debian-installer-launcher

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install debianutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install desktop-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install desktop-file-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dh-python

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dictionaries-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install diffstat

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ditils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dkms

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dleyna-server

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dmidecode

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dmsetup

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dmz-cursor-theme

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dns-root-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dnsmasq-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dnsutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install doc-debian

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install docbook-xml

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install docutils-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install docutils-doc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dosfstools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dpkg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install dvdauthor

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install e2fslibs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install e2fsprogs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install eject

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install emacsen-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install enchant

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install eog

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install espeak-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ethtool

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install evince

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install evince-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install exim4

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install exim4-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install exim4-config

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install exim4-daemon-light

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fairymax

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fakeroot

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install file

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install file-roller

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install findutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install five-or-more

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fontconfig

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fontconfig-config

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-dejavu

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-dejavu-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-dejavu-extra

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-droid

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-liberation

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fonts-opensymbol

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install foomatic-db-compressed-ppds

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install foomatic-db-engine

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install four-in-a-row

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install freepats

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install freerdp-x11

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ftp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install fuse

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gawk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gcc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gconf-service

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gcr

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gdebi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gdebi-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gdisk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gedit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gedit-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gedit-plugins

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install genisoimage

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install geoip-database

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gettext

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gettext-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ghostscript

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gimp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gimp-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gkbd-capplet

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gksu

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install glib-networking

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install glib-networking-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install glib-networking-services

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-accessibility-themes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-bluetooth

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-calculator

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-chess

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-control-center

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-control-center-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-desktop3-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-font-viewer

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-games

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-icon-theme

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-icon-theme-symbolic

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-keyring

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-klotski

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-mahjongg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-media

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-mime-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-mines

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-nibbles

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-online-accounts

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-orca

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-power-manager

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-robots

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-screenshot

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-session-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-settings-daemon

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-sudoku

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-sushi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-system-monitor

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-terminal

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-terminal-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-tetravex

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-themes-standard

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-themes-standard-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-user-guide

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-user-share

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnome-video-effects

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnote

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnupg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnupg-agent

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnupg2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnustep-base-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnustep-base-runtime

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gnustep-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gpgv

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install grep

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install groff-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install growisofs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gsettings-desktop-schemas

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gsfonts
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gvfs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gvfs-backends

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gvfs-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gvfs-daemons

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gvfs-libs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install gzip

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hamster-applet

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hardening-includes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hicolor-icon-theme

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hitori

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hoichess

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install host

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hostname

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hp-ppd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hplip

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hplip-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hunspell-en-us

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install hwdata

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iagno

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iamerican

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ibritish

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install icedove

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iceweasel

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ienglish-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ifupdown

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install imagemagick

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install imagemagick-6.q16

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install imagemagick-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install info

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install init

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install init-system-helpers

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install initramfs-tools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install initscripts

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install inkscape

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install insserv

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install install-info

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install intltool-debian

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iproute2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iptables

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iputils-arping

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iputils-ping

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install irqbalance

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install isc-dhcp-client

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install isc-dhcp-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iso-codes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ispell

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install iw

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install javascript-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install keyboard-configuration

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install klibc-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install kmod

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install krb5-locales

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install less

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libao-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libapr1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libaprutil1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libaprutil1-ldap

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libapt-pkg-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libarchive-extract-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libarchive-zip-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libasprintf-dev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libatk-adaptor

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libaudit-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libauthen-sasl-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libavahi-common-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libblas-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libc-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libc-dev-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcairo-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcanberra-pulse

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcaribou-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcgi-fast-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcgi-pm-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libclass-accessor-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libclass-isa-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libclone-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcogl-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libcpan-meta-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdata-optlist-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdata-section-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdigest-hmac-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdjvulibre-text

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdpkg-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libdrm-radeon1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libemail-valid-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfakeroot

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfcgi-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-basedir-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-copy-recursive-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-desktopentry-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-fcntllock-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-listing-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfile-mimeinfo-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libfont-afm-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libglapi-mesa

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libgnome-keyring-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libgnomeui-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libgpod-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libgweather-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhtml-form-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhtml-format-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhtml-parser-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhtml-tagset-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhtml-tree-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhttp-cookies-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhttp-daemon-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhttp-date-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhttp-message-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libhttp-negotiate-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libimage-magick-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libintl-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libio-html-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libio-pty-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libio-socket-ssl-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libio-string-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libipc-run-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblangtag-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblist-moreutils-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblocale-gettext-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblockfile-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblockfile1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblog-message-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblog-message-simple-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblognorm1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblouis-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblwp-mediatypes-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liblwp-protocol-https-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmailtools-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmbim-proxy

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmeanwhile1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmodule-build-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmodule-pluggable-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmodule-signature-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmro-compat-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmtp-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libmtp-runtime

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-dbus-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-dns-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-domain-tld-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-http-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-ip-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-smtp-ssl-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnet-ssleay-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnm-gtk-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnss-mdns

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libnss-myhostname

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libopenal-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpackage-constants-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpam-gnome-keyring

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpam-modules

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpam-modules-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpam-runtime

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpam-systemd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpango-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpaper-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpaper1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libparams-util-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libparse-debianchangelog-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpeas-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpod-latex-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpod-readme-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libpwquality-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libquvi-scripts

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libregexp-common-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-avmedia-backend-gstreamer

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-base-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-calc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-draw

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-gnome

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-gtk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-impress

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-math

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-style-galaxy

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-style-tango

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libreoffice-writer

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsane

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsane-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsane-extras

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsane-extras-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsane-hpaio

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsecret-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libselinux1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsemanage-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsmbclient

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsnmp-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsoftware-license-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsub-exporter-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsub-install-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libsub-name-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libswitch-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtag1-vanilla

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libterm-ui-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtevent0

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-charwidth-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-iconv-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-levenshtein-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-soundex-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-template-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-unidecode-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtext-wrapi18n-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libthai-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtie-ixhash-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libtimedate-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install liburi-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libuuid-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwacom-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwildmidi-config

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwmf-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwnck-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwww-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libwww-robotrules-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-libxml-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-namespacesupport-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-parser-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-sax-base-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-sax-expat-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-sax-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-twig-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install libxml-xpathengine-perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lightdm

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lightdm-gtk-greeter

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lightsoff

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lintian

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install locales

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install login

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install logrotate

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lp-solve

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lsb-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lsb-release

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install lsof

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install m4

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install make

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install man-db

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install manpages

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install manpages-dev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mate-icon-theme

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mate-themes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mawk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install media-player-info

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install menu

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mesa-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mime-support

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install minissdpd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mlocate

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mobile-broadband-provider-info

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install modemmanager

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mount

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mousetweaks

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mscompress

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install muffin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install muffin-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install multiarch-support

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install murrine-themes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install mutt

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nano

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nautilus

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nautilus-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nautilus-sendto

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ncurses-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ncurses-bin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ncurses-term

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nemo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nemo-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nemo-fileroller

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install net-tools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install netbase

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install netcat-traditional

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install netpbm

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install network-manager

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install network-manager-gnome

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nfacct

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install nfs-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ntfs-3g

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install openprinting-ppds

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install openssh-client

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install openssh-server

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install openssh-sftp-server

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install openssl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install p7zip-full

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install packagekit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install packagekit-tools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install parted

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install passwd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install patch

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install patchutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pciutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install perl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install perl-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install perl-modules

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install perlmagick

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pidgin

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pidgin-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install plymouth

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install plymouth-themes

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install plymouth-x11

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install policykit-1

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install policykit-1-gnome

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install poppler-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install poppler-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install powertop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ppp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install procps

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install psmisc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pstoedit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pulseaudio

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pulseaudio-module-x11

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install pulseaudio-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-apt

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-apt-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-cairo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-chardet

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-cups

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-cupshelpers

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-dbus

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-dbus-dev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-debian

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-debianbts

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-defusedxml

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-docutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gconf

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gi-cairo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gnome2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gobject

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gobject-2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-gtk2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-imaging

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-libxml2

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-lxml

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-minimal

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-notify

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-numpy

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pam

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pexpect

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pil

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pkg-resources

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pyatspi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pycurl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pygments

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pyinotify

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-pyorbit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-renderpm

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-reportbug

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-reportlab

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-reportlab-accel

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-roman

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-six

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-smbc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-soappy

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-support

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-talloc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-wnck

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-wstools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-xdg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python-zeitgeist

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python2.7

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python2.7-minimal

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-apt

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-brlapi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-cairo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-chardet

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-dbus

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-debian

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-gi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-gi-cairo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-louis

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-mako

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-markupsafe

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-minimal

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-pkg-resources

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-pyatspi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-six

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-speechd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-uno

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3-xdg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3.4

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install python3.4-minimal

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install qdbus

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install qpdf

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install qt-at-spi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install qtchooser

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install quadrapassel

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rarian-compat

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install readline-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install realmd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rename

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install reportbug

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rhythmbox

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rhythmbox-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rhythmbox-plugin-cdrecorder

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rhythmbox-plugins

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rpcbind

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rsync

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rsyslog

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rtkit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install rygel

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install samba-libs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sane-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sed

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sensible-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sgml-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sgml-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install shared-mime-info

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install shotwell

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install shotwell-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install simple-scan

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sound-juicer

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sound-theme-freedesktop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install speech-dispatcher

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install speech-dispatcher-audio-plugins

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ssl-cert

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install startpar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sudo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install swell-foop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install synaptic

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install system-config-printer

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install system-config-printer-udev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install systemd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install systemd-sysv

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sysv-rc

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install sysvinit-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install t1utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tali

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-cinnamon-desktop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-desktop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-english

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-laptop

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-print-server

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install task-ssh-server

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tasksel

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tasksel-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tcl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tcpd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install telnet

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install texinfo

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install time

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install totem

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install totem-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install totem-plugins

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install traceroute

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install transfig

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install transmission-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install transmission-gtk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install tzdata

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ucf

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install udev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unzip

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install update-inetd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install upower

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install ure

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install usb-modeswitch

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install usb-modeswitch-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install usbmuxd

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install usbutils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install user-setup

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install util-linux

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install util-linux-locales

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install uuid-runtime

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install vim-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install vim-tiny

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install vinagre

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install vino

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install w3m

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wamerican

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wget

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install whiptail

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install whois

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wireless-regdb

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wireless-tools

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wodim

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install wpasupplicant

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-apps

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-session-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-xkb-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install x11-xserver-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xauth

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xbitmaps

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xboard

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xbrlapi

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xchat

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xchat-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xdg-user-dirs

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xdg-user-dirs-gtk

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xdg-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xfonts-base

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xfonts-encodings

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xfonts-scalable

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xfonts-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xinit

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xkb-data

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xml-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xorg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xorg-docs-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-xorg

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-xorg-core


LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-xorg-input-all

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-xorg-input-mouse

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xserver-xorg-video-fbdev

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xterm

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xwayland

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xz-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install yelp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install yelp-xsl

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zeitgeist

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zeitgeist-core

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zeitgeist-datahub

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zenity

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zenity-common

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zerofree

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zlib1g

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unrar-free

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unace

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unrar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unalz

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install unar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install p7zip-rar

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install patool

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xz-utils

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install xzdec

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install zp

LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ apt-get install file-roller
#######################################################################

###############################################################################################
#chroot $R tasksel --new-install install xfce-desktop  --debconf-apt-progress --logstderr
#chroot $R apt-get -y --force-yes install kernel-wedge nfs-kernel-server
###############################################################################################

# Set up fstab
cat <<EOM >$R/etc/fstab
LABEL=ROOTFS / ext4  errors=remount-ro,defaults,noatime,nodiratime 0 1
LABEL=BOOT /boot vfat defaults,rw,owner,flush,umask=000 0 0
tmpfs /tmp tmpfs nodev,nosuid,mode=1777 0 0
#LABEL=SWAP      none  swap   defaults   0 0
EOM
# Set up hosts

echo odroid-xu-${RELEASE} >$R/etc/hostname
cat <<EOM >$R/etc/hosts
127.0.0.1       localhost
::1             localhost ip6-localhost ip6-loopback
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters

127.0.1.1       odroid-xu-${RELEASE}
EOM







# Set up default user (password: "odroid-xu")
chroot $R adduser --gecos "odroid-xu" --add_extra_groups --disabled-password odroid-xu
chroot $R usermod -a -G sudo -p '336569f49351e5cbb208299f3d28b951a0e5b36a24641cb9b1dc79f6eb53c11a5a0ad6101573923bc7f25009427065e3' odroid-xu
                                  
# Set up root password (password: "odroid-xu")
chroot $R usermod -p '336569f49351e5cbb208299f3d28b951a0e5b36a24641cb9b1dc79f6eb53c11a5a0ad6101573923bc7f25009427065e3' root

# Clean cached downloads
chroot $R apt-get clean

# Set up interfaces
cat <<EOM >$R/etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

EOM
cat <<EOM >$R/root/.profile
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n

EOM


cat <<EOM >$R/etc/modprobe.d/alsa-base.conf
# autoloader aliases
install sound-slot-0 /sbin/modprobe snd-card-0
install sound-slot-1 /sbin/modprobe snd-card-1
install sound-slot-2 /sbin/modprobe snd-card-2
install sound-slot-3 /sbin/modprobe snd-card-3
install sound-slot-4 /sbin/modprobe snd-card-4
install sound-slot-5 /sbin/modprobe snd-card-5
install sound-slot-6 /sbin/modprobe snd-card-6
install sound-slot-7 /sbin/modprobe snd-card-7
# Cause optional modules to be loaded above generic modules
install snd /sbin/modprobe --ignore-install snd && { /sbin/modprobe --quiet snd-ioctl32 ; /sbin/modprobe --quiet snd-seq ; : ; }
install snd-rawmidi /sbin/modprobe --ignore-install snd-rawmidi && { /sbin/modprobe --quiet snd-seq-midi ; : ; }
install snd-emu10k1 /sbin/modprobe --ignore-install snd-emu10k1 && { /sbin/modprobe --quiet snd-emu10k1-synth ; : ; }
# Keep snd-pcsp from beeing loaded as first soundcard
options snd-pcsp index=-2
# Keep snd-usb-audio from beeing loaded as first soundcard
options snd-usb-audio index=-2
# Prevent abnormal drivers from grabbing index 0
options bt87x index=-2
options cx88_alsa index=-2
options snd-atiixp-modem index=-2
options snd-intel8x0m index=-2
options snd-via82xx-modem index=-2

EOM
cat <<EOM >$R/etc/modprobe.d/alsa-base-blacklist.conf
# Uncomment these entries in order to blacklist unwanted modem drivers
# blacklist snd-atiixp-modem
# blacklist snd-intel8x0m
# blacklist snd-via82xx-modem
# Comment this entry in order to load snd-pcsp driver
blacklist snd-pcsp
EOM
cat <<EOM >$R/etc/modprobe.d/blacklist-ralink.conf
blacklist rt2x00usb
blacklist rt2x00lib
blacklist rt2800usb
blacklist rt2800lib
EOM
# This file blacklists most old-style PCI framebuffer drivers.
cat <<EOM >$R/etc/modprobe.d/fbdev-blacklist.conf
blacklist arkfb
blacklist aty128fb
blacklist atyfb
blacklist radeonfb
blacklist cirrusfb
blacklist cyber2000fb
blacklist gx1fb
blacklist gxfb
blacklist kyrofb
blacklist matroxfb_base
blacklist mb862xxfb
blacklist neofb
blacklist nvidiafb
blacklist pm2fb
blacklist pm3fb
blacklist s3fb
blacklist savagefb
blacklist sisfb
blacklist tdfxfb
blacklist tridentfb
blacklist viafb
blacklist vt8623fb

EOM
cat <<EOM >$R/etc/init.d/exynos5-hwcomposer
#!/bin/bash
# Hardkernel Co, Ltd.

touch /var/lock/exynos5-hwcomposer

start_hw_composer() {
	echo "Starting Exynos5 HW Composer"
	/usr/bin/exynos5-hwcomposer > /dev/null 2>&1 &
}

stop_hw_composer() {
	echo "Stopping Exynos5 HW Composer"
	killall -9 exynos5-hwcomposer
}

case "$1" in
	start)
		start_hw_composer
		;;
	stop)
		stop_hw_composer
		;;
	restart)
		stop_hw_composer
		start_hw_composer
		;;
	*)
		echo "Usage: /etc/init.d/exynos5-hwcomposer {start|stop|restart}"
		exit 1
		;;
esac

exit 0
EOM
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ chmod +x /etc/init.d/exynos5-hwcomposer
LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ update-rc.d exynos5-hwcomposer defaults
######################################################################################################################
#####################################################                                                                #
    ####mkdir                                                                                                        #
    sudo  mkdir $R/lib/firmware                                                                                      #
    #                                                                                                                #
    cd  $R'/tmp/'                                                                                                    #
    #######                                                                                                          #
    ## wget odroidxu.tar.xz ## kernet 3.4.104                                                                        #                         
    sudo wget http://builder.mdrjr.net/kernel-3.4/2014.11.18-11.34/odroidxu.tar.xz                                   #
                                                                                                                     #
    sudo unxz  $R/tmp/odroidxu.tar.xz                                                                                #
    sudo tar -xvf  $R/tmp/odroidxu.tar -C   $R/                                                                      #  
                                                                                                                     #
    #######                                                                                                          #       
    ## wget firmware.tar.xz                                                                                          #     
    sudo wget http://builder.mdrjr.net/tools/firmware.tar.xz                                                         #                                                               #
                                                                                                                     #
    sudo unxz  $R/tmp/firmware.tar.xz                                                                                #                                                                                            
    tar -xvf   $R/tmp/firmware.tar -C  $R/lib/firmware/                                                              #
                                                                                                                     #
    ######                                                                                                           #      
    ## wget debian_hwcomposer.tar                                                                                    #
    sudo wget http://builder.mdrjr.net/tools/debian_hwcomposer.tar                                                   #
                                                                                                                     #
    tar -xvf $R/tmp/debian_hwcomposer.tar -C  $R/usr/                                                                #
######################################################################################################################
## remove odroidxu.tar.xz / firmware.tar.xz / debian_hwcomposer.tar

#    LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ rm -r  /tmp/odroidxu.tar.xz >> $TEMP_LOG 2>&1
#    LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ rm -r  /tmp/firmware.tar.xz  >> $TEMP_LOG 2>&1
#    LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ rm -r /tmp/debian_hwcomposer.tar  >> $TEMP_LOG 2>&1
####################################################################################################################################################
    export K_VERSION=`ls $R'/lib/modules/'`
    LC_ALL=C LANGUAGE=C LANG=C sudo chroot $R/ update-initramfs -c -k $K_VERSION
    sudo mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n "uInitrd $K_VERSION" -d $R"/boot/initrd.img-$K_VERSION" $R'/boot/uInitrd'
####################################################################################################################################################


################## boot/boot.ini
cat <<EOM >$R'/boot/boot.ini'
#------------------------------------------------------------------------------------------------------
#
# Boot.ini text file template
#
#------------------------------------------------------------------------------------------------------
#
# boot.ini identification
#
#------------------------------------------------------------------------------------------------------
ODROIDXU-UBOOT-CONFIG

# Verify if u-boot is up-to-date to receive new Kernel
setenv hk_current_version "2"
setenv verify 'if test $hk_version != $hk_current_version;then;fatload mmc 0:1 40008000 u-boot.bin;emmc open 0;movi w z u 0 40008000;emmc close 0;setenv hk_version $hk_current_version;save;reset;fi'
run verify

# U-Boot Parameters
setenv initrd_high "0xffffffff"
setenv fdt_high "0xffffffff"

#------------------------------------------------------------------------------------------------------
#
# Boot Specific Stuff
# Ubuntu
setenv bootrootfs "console=tty1 console=ttySAC2,115200n8 root=UUID=e6c1b4a6-f773-4ea7-b83b-75b40866412e rootwait ro"

# Android
# setenv bootroofs "root=/dev/mmcblk0p2 rw rootfstype=ext4 init=/init console=ttySAC2,115200n8 vmalloc=512M"                                              

#------------------------------------------------------------------------------------------------------
#
# Frame buffer size.
# Example.. If you are on LCD Kit set the values bellow to:
# x = 1280 and y = 800
# Otherwise please set this value below to your wanted resolution
# Values:
# LCD Kit: x = 1280   y = 800
#  ---------------------------
# HDMI:
#    480: x = 720    y = 480
#    576: x = 720    y = 576
#    720: x = 1280   y = 720
#   1080: x = 1920   y = 1080
#
#------------------------------------------------------------------------------------------------------
setenv fb_x_res     "1280"
setenv fb_y_res     "720"

#------------------------------------------------------------------------------------------------------
#
# Controls the Board Output Method.
# Valid values are: lcd dp hdmi dvi
#
#------------------------------------------------------------------------------------------------------
setenv vout         "hdmi"

#------------------------------------------------------------------------------------------------------
#
# FB Control
#
#------------------------------------------------------------------------------------------------------
setenv left     "56"
setenv right    "24"
setenv upper    "3"
setenv lower    "3"
setenv hsync    "14"
setenv vsync    "3"

setenv fb_control "left=${left} right=${right} upper=${upper} lower=${lower} vsync=${vsync} hsync=${hsync}"

#------------------------------------------------------------------------------------------------------
#
# Ĺ×˝şĆŽ ľÇžîÁř ¸đ´ĎĹÍŔÇ parameter°ŞŔÔ´Ď´Ů. Ŕ§ °ŞŔť źłÁ¤ÇŇ ś§ Âü°íÇĎżŠ ťçżëÇŐ´Ď´Ů.
#
#------------------------------------------------------------------------------------------------------
#
# AOC I2269V 22" (1920 X 1080)
# left = 56, right = 24, upper = 3, lower = 3, hsync = 14, vsync = 3
#
#------------------------------------------------------------------------------------------------------
#
# YAMAKASI Monitor 27" (2560 X 1440)
# left = 15, right = 10, upper = 10, lower = 10, hsync = 10, vsync = 10,
#
#------------------------------------------------------------------------------------------------------
#
# X-Star Monitor 27" (2560 X 1440)
# left = 56, right = 24, upper = 3, lower = 3, hsync = 14, vsync = 3,
#
#------------------------------------------------------------------------------------------------------
#
# LG Monitor 27" (2560 * 1080)
#
# left = 56, right = 248, upper = 3, lower = 3, hsync = 144, vsync = 3,
# left = 100, right = 100, upper = 100, lower = 100, hsync = 100, vsync = 100,
#
#------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------
#
# Forces a fixed resolution on the HDMI controller. Please make sure that your screen supports and
# It matchs the resolution above! setted the X and Y
# valid values are: 480p60hz 720p60hz 720p50hz 1080p60hz 1080i60hz 1080i50hz 1080p50hz
#		    1080p30hz 1080p25hz 1080p24hz
#
#------------------------------------------------------------------------------------------------------
setenv hdmi_phy_res "720p60hz"

#------------------------------------------------------------------------------------------------------
#
# System Status LED: Blink the RGB LED or disable it
# valid values: 1 off
#
#------------------------------------------------------------------------------------------------------
setenv led_blink    "1"

#------------------------------------------------------------------------------------------------------
#
# U-Boot bootcmd command
#  
#------------------------------------------------------------------------------------------------------
# Android
# setenv bootcmd "movi r k 0:1 40008000; bootz 0x40008000"
# Ubuntu
setenv bootcmd "fatload mmc 0:1 0x40008000 zImage; fatload mmc 0:1 0x42000000 uInitrd; bootz 0x40008000 0x42000000"

#------------------------------------------------------------------------------------------------------
#
# Kernel boot arguments
#
#------------------------------------------------------------------------------------------------------
setenv bootargs "${bootrootfs} ${fb_control} fb_x_res=${fb_x_res} fb_y_res=${fb_y_res} vout=${vout} hdmi_phy_res=${hdmi_phy_res} led_blink=${led_blink}"

# Boot the board
boot
__EOF__



# Unmount mounted filesystems
umount -l $R/proc
umount -l $R/sys

# Clean up files
rm -f $R/etc/apt/sources.list.save
rm -f $R/etc/resolvconf/resolv.conf.d/original
rm -rf $R/run
mkdir -p $R/run
rm -f $R/etc/*-
rm -f $R/root/.bash_history
rm -rf $R/tmp/*
rm -f $R/var/lib/urandom/random-seed
[ -L $R/var/lib/dbus/machine-id ] || rm -f $R/var/lib/dbus/machine-id
rm -f $R/etc/machine-id

# Build the image file
# Currently hardcoded to a 3.75GiB image
DATE="$(date +%Y-%m-%d)"
dd if=/dev/zero of="$BASEDIR/${DATE}-debian-${RELEASE}.img" bs=1M count=1
dd if=/dev/zero of="$BASEDIR/${DATE}-debian-${RELEASE}.img" bs=1M count=0 seek=3840



sfdisk -f "$BASEDIR/${DATE}-debian-${RELEASE}.img" <<EOM
unit: sectors

1 : start=     2048, size=   131072, Id= c, bootable
2 : start=   133120, size=  7731200, Id=83
3 : start=        0, size=        0, Id= 0
4 : start=        0, size=        0, Id= 0
EOM

VFAT_LOOP="$(losetup -o 1M --sizelimit 64M -f --show $BASEDIR/${DATE}-debian-${RELEASE}.img)"
EXT4_LOOP="$(losetup -o 65M --sizelimit 4775M -f --show $BASEDIR/${DATE}-debian-${RELEASE}.img)"
mkfs.vfat -n BOOT "$VFAT_LOOP"
mkfs.ext4 -L ROOTFS "$EXT4_LOOP"
MOUNTDIR="$BUILDDIR/mount"
mkdir -p "$MOUNTDIR"
mount "$EXT4_LOOP" "$MOUNTDIR"
mkdir -p "$MOUNTDIR/boot"
mount "$VFAT_LOOP" "$MOUNTDIR/boot"
rsync -a "$R/" "$MOUNTDIR/"
umount "$MOUNTDIR/boot"
umount "$MOUNTDIR"
losetup -d "$EXT4_LOOP"
losetup -d "$VFAT_LOOP"
bmaptool create -o "$BASEDIR/${DATE}-debian-${RELEASE}.bmap" "$BASEDIR/${DATE}-debian-${RELEASE}.img"
#                                                                                                                #
cd  $R'/tmp/'    
wget http://builder.mdrjr.net/tools/uboot-xu.tar
tar -xf uboot-xu.tar
cd uboot-xu
echo "      [*] Fusing media"
chmod +x fusing.sh
sudo ./fusing.sh $BASEDIR/${DATE}-debian-${RELEASE}.bmap" "$BASEDIR/${DATE}-debian-${RELEASE}.img
rm uboot-xu.tar
rm -r uboot-xu
echo OK
