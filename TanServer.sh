#!/bin/bash
clear
echo -e "\e[32mWelcome to Tan Server SetUp"
read -r -p "Are you sure? [y/N] " response
if [[ $response == [yY]* ]]
then
	clear
	read -r -p "Enter OpenVPN password: " password
	read -r -p "Enter TanJay password: " passwordt
	clear
	echo -e "\e[32mUpdating Ubuntu"
	sudo apt-get update > /dev/null
	echo -e "\e[32mUpdate Complete"
    echo -e "\e[32mSetting Up the OpenVPN"
    sudo wget http://swupdate.openvpn.org/as/openvpn-as-2.0.7-Ubuntu12.amd_64.deb >/dev/null 2>&1
    dpkg -i openvpn-as-2.0.7-Ubuntu12.amd_64.deb > /dev/null
    echo openvpn:$password | chpasswd > /dev/null
    echo -e "\e[32mOpenVPN installed Successfully"
    echo -e "\e[32mSetting up the transmission"
    sudo apt-get install python-software-properties -y > /dev/null
    #Have to press enter to add repository 
    echo -e "\e[32mAdding add-apt-repository"
    sudo add-apt-repository ppa:transmissionbt/ppa -y >/dev/null 2>&1
    sudo apt-get update > /dev/null
    #For tansmission y is required //Fixed
    echo -e "\e[32minstalling transmissionbt" 
    sudo apt-get install transmission-cli transmission-common transmission-daemon -y > /dev/null
    echo -e "\e[32mMaking Directories"
    mkdir /home/Downloads > /dev/null
    mkdir /home/Downloads/Completed > /dev/null
    mkdir /home/Downloads/Incomplete > /dev/null
    mkdir /home/Downloads/Torrents > /dev/null
    echo -e "\e[32mAdding Users"
    useradd TanJay > /dev/null
    echo -e "\e[32mChanging Passwords"
    echo TanJay:$passwordt | chpasswd > /dev/null
    echo -e "\e[32mChanging Permissions"
    sudo usermod -a -G debian-transmission TanJay > /dev/null
    sudo chgrp -R debian-transmission /home/Downloads > /dev/null
    sudo chmod -R 775 /home/Downloads > /dev/null
    echo -e "\e[32mStopping transmissionbt"
    sudo /etc/init.d/transmission-daemon stop > /dev/null
    echo -e "\e[32mediting the Config file"
    mv "/etc/transmission-daemon/settings.json" "/etc/transmission-daemon/settings.json.bk" > /dev/null
    wget dl.dropboxusercontent.com/s/i3euym0od8ihb7l/file.txt >/dev/null 2>&1
    mv file.txt /etc/transmission-daemon/settings.json >/dev/null 2>&1
    #Needs y to continue //Fixed
    echo -e "\e[32mInstall Required tools"
    sudo apt-get install nano > /dev/null
    sudo apt-get --ignore-missing install curl libc6 libcurl3 zlib1g -y > /dev/null
    echo -e "\e[32mDownloading the block list"
	wget http://ip2k.com/list.gz >/dev/null 2>&1
	gunzip list.gz >/dev/null 2>&1
	echo -e "\e[32mPlacing the blocklists"
	cp list /var/www/list.txt > /dev/null
	echo -e "\e[32mStarting the transmissionbt"
	sudo /etc/init.d/transmission-daemon start > /dev/null
	#Installing WebServer needs y to continue //Fixed
	echo -e "\e[32mInstalling the Web Server(Webmin)"
	sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y > /dev/null
	wget http://prdownloads.sourceforge.net/webadmin/webmin_1.580_all.deb >/dev/null 2>&1
	sudo dpkg -i webmin_1.580_all.deb > /dev/null
	echo -e "\e[32mInstalling octave"
	sudo apt-get install octave -y >/dev/null 2>&1
	echo -e "\e[32moctave installed Successfully"
	echo -e "\e[32mInstall nmap"
	sudo apt-get install nmap -y >/dev/null 2>&1
	echo -e "\e[32mInstallation Done"
	echo -e "\e[32mRemoving unwanted files" 
	rm * -f
	echo -e "All Done Exiting...."
	exit
else
    echo -e "\e[32mClose Me"
    exit
fi

