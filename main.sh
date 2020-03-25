#!/bin/sh

readonly BASE_PATH='/home/yuzunoha/git/docker-nextcloud1'
readonly NEXTCLOUD_DIR_P=$BASE_PATH'/primary/nextcloud/'
readonly NEXTCLOUD_DIR_S=$BASE_PATH'/secondary/nextcloud'

secondary_db_1

echo $NEXTCLOUD_DIR_P
echo $NEXTCLOUD_DIR_S

docker exec secondary_db_1 whoami

cd $NEXTCLOUD_DIR_P
pwd

#echo 'rsync start'
#rsync -Aavx /home/yuzunoha/git/docker-nextcloud1/primary/nextcloud/ /home/yuzunoha/git/docker-nextcloud1/secondary/nextcloud/
#echo 'rsync end'
