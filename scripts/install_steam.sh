#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "ROOT MEH! (sudo -s)"
fi

if [[ "$(id -u steam > /dev/null 2>&1; echo $?)" != "0" ]]; then
	useradd -m -s /bin/bash steam
fi
sudo apt-get install steamcmd

if [[ -f /usr/bin/steamcmd ]] || [[ -s /usr/bin/steamcmd ]]; then
	rm -f /usr/bin/steamcmd
fi
ln -s /usr/games/steamcmd /usr/bin/steamcmd

echo "Now run steamcmd and install your apps as per their instructions. Don't forget to 'sudo -s -u steam' in future. :)"
sudo -s -u steam

