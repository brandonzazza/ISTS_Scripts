#!/bin/bash


declare -i uid

scored_user=$1

if [ $# -eq 0 ]
then 
	echo "who is scored user"
	exit 1
fi

echo "change root pass"
passwd root
echo "change scored user pass"
passwd $scored_user

while read l; do
	uid=`echo $l | awk -F ":" '{print $3}'`
	name=`echo $l | awk -F ":" '{print $1}'`
	if [ $uid -ge 1000 ] && [ "$name" != "$scored_user" ] 
	then
		echo $name $scored_user $uid
		passwd -l $name
		usermod -s /sbin/nologin $name
	fi
done < /etc/passwd
usermod -G sudo $scored_user
chattr +i /etc/passwd
chattr +i /etc/ssh/*config
chattr +i ~/.bashrc
chattr +i /home/$scored_user/.bashrc
chattr +i /var/www/html/*
su $scored_user
