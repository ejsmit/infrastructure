#!/bin/bash

set -e

DOW=$(date +%u)
bucket=daily
age=14d
if [ $DOW == 7 ]; then
    bucket=weekly
    age=8w
fi
# echo $bucket

# backup pihole
cd $HOME
rm --force pi-hole-{{hostname}}-teleporter* 
/usr/local/bin/pihole -a -t

# encrypt
# gpg --recipient $me --encrypt pi-hole-{{hostname}}-teleporter*

rclone move pi-hole-{{hostname}}-teleporter*  backblaze_b2:ejsmit-pihole/$bucket
rclone delete --min-age $age backblaze_b2:ejsmit-pihole/$bucket

# send a notification
/usr/local/bin/telegram-notify --quiet --success --text "{{hostname}} pihole $bucket backup"


