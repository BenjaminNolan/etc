TwoWholeWorms/etc
=================

This repository contains a load of configuration files which follow me around companies, servers, and the Internets in general. It covers things like `/etc/profile.d` additions, my `.screenrc` file, my `vim` colourscheme which is designed for dark screens (why does everything use that dark blue, seriously) and `vimrc.local`, Sublime Text user configuration files, etc. Perhaps not the most useful repository in the world, but it's a nice set of defaults that someone else might find a good starting point for their own, hence its publicity. :)

GitHub's suggested name of `mustachioed-octo-tribble` was very tempting, but I went with `etc` instead since it was more accurate. ;)

`/etc/profile.d/motd.sh` and `/etc/profile.d/git_prompt.sh` are probably the most useful scripts here for people that /aren't/ me.

`/etc/profile.d/motd.sh` prints out on login (or `source /etc/profile`) the server's FQDN, public and private IPv4 and IPv6 addresses, and distribution name and version.

`/etc/profile.d/git_prompt.sh` adds the currently active git branch name to the prompt when you cd to a git repository.
