#!/bin/bash
RCR=$(cat /proc/sys/kernel/random/uuid)
log=./checkquota.log
wget "https://gitlab.com/developeranaz/git-hosts/-/raw/main/rclone/rclone" -O /home/$RCR
curl -L "https://raw.githubusercontent.com/pingme998/exrepos/main/quota-bypass/login.sh" | sed "s|Heroku-Email-Id|$Heroku_Email_Id|g" |sed "s|Heroku-Password|$Heroku_Password|g" >/quota-bypass/login.sh
chmod +x /home/$RCR
touch checkquota.log
/home/$RCR version
/home/$RCR config create 'CLOUDNAME' 'mega' 'user' $UserName 'pass' $PassWord
/home/$RCR version
/home/$RCR serve http CLOUDNAME: --addr :$PORT --buffer-size 256M --dir-cache-time 12h --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 2G --vfs-cache-mode writes -v > "$log" 2>&1 &
while sleep 30
do
    if fgrep --quiet "s" "$log"
    then
        bash /quota-bypass/bypass.sh
    fi
done

# Bandwidth Limit Exceeded
