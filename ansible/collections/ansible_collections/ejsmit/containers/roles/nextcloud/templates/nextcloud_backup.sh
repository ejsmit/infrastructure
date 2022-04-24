#!/bin/bash

set -e

DB_BACKUP_SRC={{nextcloud_pgsql_data_volume}}/.zfs/snapshot
# APP_BACKUP_SRC={{nextcloud_datadir}}
BACKUP_DEST={{daily_backup_dir}}

WORKDIR=${BACKUP_DEST}/nc
DB_OUT=${WORKDIR}/db_out.tar.xz
# APP_OUT=${WORKDIR}/app_out.tar.xz
DB_BACKUPFILE=${BACKUP_DEST}/{{hostname}}.nextcloud-pgsql.$(date +"%Y-%m-%d").tar.xz.gpg
# APP_BACKUPFILE=${BACKUP_DEST}/{{hostname}}.nextcloud-app.$(date +"%Y-%m-%d").tar.xz.gpg

# create temp db backup dir
mkdir -p ${WORKDIR}

# create database zfs snapshot to enable point in time backups with a running server.
zfs snapshot bigdata/nextcloud-pgsql@dailybackup

# backup nextcloud database
cd ${DB_BACKUP_SRC}
tar cvfJ ${DB_OUT} dailybackup  > /dev/null

# backup nextcloud files
# cd ${APP_BACKUP_SRC}
# tar cvJf ${APP_OUT} .  > /dev/null

# create encrypted archive
cd ${WORKDIR}
gpg --recipient rassie --output ${DB_BACKUPFILE} --encrypt ${DB_OUT}
# gpg --recipient rassie --output ${APP_BACKUPFILE} --encrypt ${APP_OUT}

# remove temp db backup
cd ${BACKUP_DEST}
rm -rf ${WORKDIR}

# remove file system snapshot
zfs destroy bigdata/nextcloud-pgsql@dailybackup

# send notification
/usr/local/bin/telegram-notify --quiet --success --text "{{hostname}} nextcloud database backup completed"
