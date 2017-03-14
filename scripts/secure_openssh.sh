#!/bin/bash

pass=Danglebl0rts

if [ "$EUID" -ne 0 ]; then
	echo "You need to be root to run this script. (I recommend sudo -s)"
fi

while true; do
    echo "DO NOT RUN THIS UNTIL YOU HAVE ADDED A PUBLIC KEY TO ~/.ssh/authorized_keys FOR A USER THAT IS NOT ROOT!"
	echo "If you have done this, then type the word '${pass}' now: "
	read input
	if [[ "$input" != "$pass" ]]; then
		echo "You are not ready. Exiting!"
		exit 1
    fi
done

echo "Upping server key bits."
sed -i.bak "s/ServerKeyBits 1024/ServerKeyBits 2048/" /etc/ssh/sshd_config

echo "Disabling root log-ins."
sed -i.bak "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config

echo "Disabling password authentication."
sed -i.bak "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

# Generate a decent Diffie-Hellman parameters file. Not strictly a part of the OpenSSH stuff, but, y'know. Good
# practice, and all that bollocks. Link this from your webserver configs to make your SSL connections more, y'know...
# S. Also, you should always check your boxen with ssllabs.com's free checky thing. No, I don't work for them. :)
echo "Generating DH params file."
openssl dhparam -outform PEM -out /etc/nginx/ssl/dhparam.pem 4096

echo "SSH config secured."
echo ""
echo "LEESEN CAREFULLY FOR I VILL SAY ZIS EAUNLY VUNS!"
echo ""
echo "DO NOT DISCONNECT THIS SESSION. You will need it to fix any cock-ups if anything went wrong. (But hopefully it didn't)"
echo ""
echo "Try to connect now as your non-root user, and then make sure you can either sudo -s or su. If not, you have lost admin access to this server. Derp."
echo ""
echo "You were warned. :)"
echo ""
echo "Have a nice day!"
echo ""

