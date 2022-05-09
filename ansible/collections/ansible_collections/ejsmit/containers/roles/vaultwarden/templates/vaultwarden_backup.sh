#!/bin/bash

set -e

BACKUP_SRC={{vaultwarden_volume}}
BACKUP_DEST={{daily_backup_dir}}

WORKDIR=${BACKUP_DEST}/work
TEMP_OUT=${WORKDIR}/vaultwarden/vaultwarden.tar
OUT=${WORKDIR}/out.tar.xz
BACKUPFILE=${BACKUP_DEST}/{{hostname}}.vaultwarden.$(date +"%Y-%m-%d").tar.xz.gpg

# create temp db backup dir
mkdir -p ${WORKDIR}/vaultwarden

# backup vaultwarden
cd ${BACKUP_SRC}
if [[ -f "${BACKUP_SRC}/db.sqlite3" ]]; then
    sqlite3 "${BACKUP_SRC}/db.sqlite3" ".backup '${WORKDIR}/vaultwarden/db.sqlite3'"
fi
tar cvf ${TEMP_OUT} --exclude "db.sqlite*" *  > /dev/null

# create encrypted archive
cd ${WORKDIR}
tar cvJf ${OUT} vaultwarden > /dev/null
gpg --recipient rassie --output ${BACKUPFILE} --encrypt ${OUT}

# remove temp db backup
cd ${BACKUP_DEST}
rm -rf ${WORKDIR}

# send notification
/usr/local/bin/telegram-notify --quiet --success --text "{{hostname}} vaultwarden backup completed"
