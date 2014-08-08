TwoWholeWorms/etc
=================

This repository contains a load of configuration files which follow me around companies, servers, and the Internets in general. It covers things like `/etc/profile.d` additions, my `.screenrc` file, my `vim` colourscheme which is designed for dark screens (why does everything use that dark blue, seriously) and `vimrc.local`, Sublime Text user configuration files, etc. Perhaps not the most useful repository in the world, but it's a nice set of defaults that someone else might find a good starting point for their own, hence its publicity. :)

GitHub's suggested name of `mustachioed-octo-tribble` was very tempting, but I went with `etc` instead since it was more accurate. ;)

`/etc/profile.d/motd.sh` and `/etc/profile.d/git_prompt.sh` are probably the most useful scripts here for people that /aren't/ me.

`/etc/profile.d/motd.sh` prints out on login (or `source /etc/profile`) the server's FQDN, public and private IPv4 and IPv6 addresses, and distribution name and version. Yes, I'm aware of `libpam_motd`, but this method doesn't require me to install and configure a module to do it, and, like all good sysadmins, I'm lazy and would rather just write a script to do it when the alternative is to write a script that's loaded by a library that I'd have to configure first. If you already have `libpam_motd` installed, you should be able to just drop this into `/etc/update-motd.d/` and it'll be inserted into your MOTD in the normal manner.

`/etc/profile.d/git_prompt.sh` adds the currently active git branch name to the prompt when you cd to a git repository.
