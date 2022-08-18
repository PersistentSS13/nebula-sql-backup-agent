#!/bin/bash
# Must set:
# SQL_HOST, SQL_USER, SQL_PASS, SQL_DB, GCP_GS_BUCKET, PREFIX


DATE=$(date '+%Y%m%d%H%M')
FILE=`echo ${PREFIX}_${DATE}.sql
mysqldump -h ${SQL_HOST} --user=${SQL_USER} --password=${SQL_PASS} ${SQL_DB} > /tmp/${FILENAME}

# remove last line so diffs can function properly
sed -i '$ d' ${FILE}

LAST_GS_FILE=`gsutil ls -l gs://${GCP_GS_BUCKET}/ | sort -k 2 | tail -n 2 | head -n 1 | awk '{ print $3 }'`
LAST_GS_HASH=`gsutil stat ${LAST_GS_FILE} | grep crc32 | awk '{ print $3 }'`
NEW_BACKUP_HASH=`gsutil hash -c /tmp/${FILENAME} | head -2 | tail -1 | awk '{ print $3 }'`

if [ "${NEW_BACKUP_HASH}" == "${LAST_GS_HASH}" ]; then
    echo "Hashes are equal, exiting..."
else
    echo "Hashes are unique, uploading..."
    gsutil cp /tmp/${FILENAME} gs://nebula-sql-backup/${FILENAME}
fi
