#!/bin/sh

readonly BASE_PATH='/home/yuzunoha/git/docker-nextcloud1'
readonly NEXTCLOUD_DIR_P=$BASE_PATH'/primary/nextcloud/'
readonly NEXTCLOUD_DIR_S=$BASE_PATH'/secondary/nextcloud'

echo $NEXTCLOUD_DIR_P
echo $NEXTCLOUD_DIR_S


cd $NEXTCLOUD_DIR_P
pwd

#echo 'rsync start'
#rsync -Aavx /home/yuzunoha/git/docker-nextcloud1/primary/nextcloud/ /home/yuzunoha/git/docker-nextcloud1/secondary/nextcloud/
#echo 'rsync end'
