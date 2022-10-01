#!/bin/bash


RCR=$(cat /proc/sys/kernel/random/uuid)
log=/exrepos/quota-bypass/checkquota.log
wget "https://gitlab.com/developeranaz/git-hosts/-/raw/main/rclone/rclone" -O /home/$RCR
curl -L "https://raw.githubusercontent.com/pingme998/exrepos/main/quota-bypass/login.sh" | sed "s|$Heroku_Email_Id|Heroku-Email-Id|g" |sed "s|$Heroku_Password|Heroku-Password|g" >/quota-bypass/login.sh
chmod +x /home/$RCR
chmod +x /exrepos/quota-bypass/*
touch /exrepos/quota-bypass/checkquota.log
/home/$RCR version
/home/$RCR config create 'CLOUDNAME' 'mega' 'user' $UserName 'pass' $PassWord
/home/$RCR version
/home/$RCR serve http CLOUDNAME: --addr :$PORT --buffer-size 256M --dir-cache-time 12h --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 2G --vfs-cache-mode writes -v > "$log" 2>&1 &
while sleep 30
do
    if fgrep --quiet "s" "$log"
    then
        bash /exrepos/quota-bypass/bypass.sh
    fi
done
