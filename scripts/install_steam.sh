#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "ROOT MEH! (sudo -s)"
fi

apt-get install -y python python-apt xterm konsole zenity
wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb

dpkg -i steam_latest.deb

