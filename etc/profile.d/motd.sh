#!/bin/bash

# Prints a nice MOTD message when you connect to the server (or source /etc/profile) which contains the server's IP addresses, etc.

if [ "$PS1" ]; then

    HOST=`hostname --fqdn`
    UNDERLINE=`printf "%-*s" "${#HOST}" "" | tr " " "="`
    UNDERLINE=`printf "%-76s" "${UNDERLINE}"`
    HOST=`printf "%-76s" "$HOST"`
    DISTRO=`printf "%-61s" "$(lsb_release -d | cut -f2-)"`

    PUBLIC_IPS=`printf "%-61s" "$(ip addr | grep 'inet' | awk '{print $2}' | grep -E '^[0-9]+\.' | grep -vE '^(127|192|172|10)\.' | sed -r 's/\/[0-9]+$//' | xargs echo)"`
    PRIVATE_IPS=`printf "%-61s" "$(ip addr | grep 'inet' | awk '{print $2}' | grep -E '^(192|172|10)\.' | sed -r 's/\/[0-9]+$//' | xargs echo)"`

    PUBLIC_IPS6=`printf "%-61s" "$(ip addr | grep 'inet' | awk '{print $2}' | grep -E '^[a-fA-F0-9]{1,4}:' | grep -Ev '^[fF][cCdD][a-fA-F0-9]{0,2}:' | sed -r 's/\/[0-9]+$//' | xargs echo)"`
    PRIVATE_IPS6=`printf "%-61s" "$(ip addr | grep 'inet' | awk '{print $2}' | grep -E '^[fF][cCdD][a-fA-F0-9]{0,2}:' | sed -r 's/\/[0-9]+$//' | xargs echo)"`

    echo -e " "
    echo -e "\033[1;34m╔══════════════════════════════════════════════════════════════════════════════╗"
    echo -e "\033[1;34m║                                                                              \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37m${HOST} \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;31m${UNDERLINE} \033[1;34m║"
    echo -e "\033[1;34m║                                                                              \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37mDistro:        \033[0;37m${DISTRO} \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37mExternal IPv4: \033[0;37m${PUBLIC_IPS} \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37mInternal IPv4: \033[0;37m${PRIVATE_IPS} \033[1;34m║"
    echo -e "\033[1;34m║                                                                              \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37mExternal IPv6: \033[0;37m${PUBLIC_IPS6} \033[1;34m║"
    echo -e "\033[1;34m║ \033[1;37mInternal IPv6: \033[0;37m${PRIVATE_IPS6} \033[1;34m║"
    echo -e "\033[1;34m║                                                                              \033[1;34m║"
    echo -e "\033[1;34m║ \033[0;37mThis server is configured to use UTF-8 as its character encoding.  If you    \033[1;34m║"
    echo -e "\033[1;34m║ \033[0;37mare not currently connected using UTF-8, please disconnect and reconnect     \033[1;34m║"
    echo -e "\033[1;34m║ \033[0;37mafter properly configuring your terminal.  If you are using PuTTY, you can   \033[1;34m║"
    echo -e "\033[1;34m║ \033[0;37mdo this by changing the encoding drop-down on the Translation page to UTF-8. \033[1;34m║"
    echo -e "\033[1;34m║                                                                              \033[1;34m║"
    echo -e "\033[1;34m╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e " "
fi
