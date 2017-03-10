#!/bin/bash

# Exit codes:
# 1 - User is not root
# 2 - Unable to create backup mount path
# 3 - Unable to mount backup path
# 4 - Unable to create / clean cron file
# 5 - Unable to add daily backup task to cron file
# 6 - Unable to add weekly backup task to cron file
# 7 - Unable to add monthly backup task to cron file

args=`getopts hdwm`
set -- $args

function displayHelpMessage($exitCode) {
    echo "This script installs the rerequisites for backing up data to Hetzner's FTP backup servers via"
    echo "curlftpfs and rsync. Simply run the script and provide the server, user, and password when requested,"
    echo "and voilà."
    echo ""
    echo "NOTE: This script must be run as root."
    echo ""
    echo "Usage: ./set_up_hetzner_backups.sh [-h]"
    echo "    -h: Displays this help message."
    echo ""
    echo "    -d: Installs a daily backup cronjob."
    echo "    -w: Installs a weekly backup cronjob."
    echo "    -m: Installs a monthly backup cronjob."

    if [[ "$exitCode" == "" ]]; then
        exit 0
    else
        exit $exitCode
    fi
}

function askQuestion($str, $checkHost) {
    userInput=""
    while true; do
        echo -n $str
        read userInput
        if [[ "$checkHost" != "" ]]; then
            output=$(getent hosts $userInput 2&>1)
            if [[ "$?" == "0" ]]; then
                break
            else
                echo "Host ${userInput} does not exist."
            fi
        fi
    done
    return $userInput
}

installDaily=0
installWeekly=0
installMonthly=0
for i; do
    case $i in
        -h*)
            displayHelpMessage()
	;;
        -d*)
            installDaily=1
	;;
        -w*)
            installWeekly=1
	;;
        -m*)
            installMonthly=1
	;;
    esac
done

if [ "$EUID" -ne 0 ]; then
    # Not root, display usage message and exit with code 1
    displayHelpMessage(1)
fi

if [[ "$installDaily" == "0" && "$installWeekly" == "0" && "$installMonthly" == "0" ]]; then
    echo "NOTE: Not installing any cronjobs. To install cronjobs, re-run this script with -d, -w, and / or -m."
fi

configsPath="~/.twwconfigs"
configFilePath="${configsPath}/backups_config.sh"

host=""
username=""
password=""

if [[ -f "$configFilePath" ]]; then
    source ${configFilePath}
fi

displayPassword=`echo ${password} | sed/./\*/g`

host=askQuestion("Backup hostname: [${host}]" , 1)
username=askQuestion("Username: [${username}]")
password=askQuestion("Password: [${displayPassword}]")

echo "host=\"${host}\"" > $configFilePath
echo "username=\"${username}\"" > $configFilePath
echo "password=\"${password}\"" > $configFilePath

mountPath=/mnt/backups
cronFilePath=/etc/cron.d/hetzner_backups.sh
excludes='--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"}'

apt-get update
apt-get install -y curlftpfs rsync ftp lftp

if [[ ! -d "${mountPath}" ]]; then
    mkdir ${mountPath}
    if [[ "$?" != "0" ]]; then
        echo "Unable to create directory ${mountPath}."
        exit 2
    fi
fi

if [[ "$(grep "${hostname}" /etc/fstab)" != "0" ]]; then
    echo "curlftpfs#${username}:${password}@${host} ${mountPath} fuse rw,allow_other,uid=1000 0 0" >> /etc/fstab
fi

mount ${mountPath}
if [[ "$?" != "0" ]]; then
    echo "Unable to mount ${mountPath}."
    exit 3
fi

echo "" > $cronFilePath
if [[ "$?" != "0" ]]; then
    echo "Unable to create / clean ${cronFilePath}."
    exit 4
fi

echo "1 0 * * * root rsync -aAXv ${excludes} --no-owner --no-group / ${mountPath}/daily" >> $cronFilePath
if [[ "$?" != "0" ]]; then
    echo "Unable to add daily backup command to ${cronFilePath}."
    exit 5
fi

echo "2 30 0 * * root rsync -aAXv ${excludes} --no-owner --no-group / ${mountPath}/weekly" >> $cronFilePath
if [[ "$?" != "0" ]]; then
    echo "Unable to add weekly backup command to ${cronFilePath}."
    exit 6
fi

echo "4 0 0 0 * root rsync -aAXv ${excludes} --no-owner --no-group / ${mountPath}/monthly" >> $cronFilePath
if [[ "$?" != "0" ]]; then
    echo "Unable to add monthly backup command to ${cronFilePath}."
    exit 7
fi

