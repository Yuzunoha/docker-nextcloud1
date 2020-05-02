#!/bin/sh

# 定数宣言
readonly BASE_PATH='/home/yuzunoha/git/docker-nextcloud1/'
readonly ROOT_PATH_P=$BASE_PATH'docker/primary/'
readonly ROOT_PATH_S=$BASE_PATH'docker/secondary/'
readonly NEXTCLOUD_PATH_P=$ROOT_PATH_P'/nextcloud/'
readonly NEXTCLOUD_PATH_S=$ROOT_PATH_S'/nextcloud/'
readonly SQL_DUMP_FILE_NAME='nextcloud-sqlbkp.bak'
readonly DB_CONTAINER_NAME_P='primary_db_1'
readonly DB_CONTAINER_NAME_S='secondary_db_1'
readonly APP_CONTAINER_NAME_P='primary_app_1'
readonly APP_CONTAINER_NAME_S='secondary_app_1'

echo 'ベースディレクトリに移動する'
cd $BASE_PATH

# TODO 全く差分のない日はお休みする
# TODO config.phpは60000とか書いてあるからこのファイルだけコピー除外する
echo 'プライマリのデータフォルダをセカンダリにコピーする'
rsync -Aax --exclude='config' $NEXTCLOUD_PATH_P $NEXTCLOUD_PATH_S

echo 'プライマリのdbをsqlファイルにエクスポートする'
docker exec $DB_CONTAINER_NAME_P mysqldump --single-transaction -u root -proot nextcloud > ./$SQL_DUMP_FILE_NAME

echo 'sqlファイルをセカンダリのdbコンテナに転送する'
docker cp ./$SQL_DUMP_FILE_NAME $DB_CONTAINER_NAME_S:/dmp

echo 'セカンダリのdbコンテナで既存のDBを削除する'
docker exec $DB_CONTAINER_NAME_S sh -c 'mysql -u nextcloud -pnextcloud -e "DROP DATABASE nextcloud"'

echo 'セカンダリのdbコンテナで既存のDBを作成する'
docker exec $DB_CONTAINER_NAME_S sh -c 'mysql -u nextcloud -pnextcloud -e "CREATE DATABASE nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci"'

echo 'セカンダリのdbコンテナでsqlファイルをインポートする'
docker exec $DB_CONTAINER_NAME_S sh -c 'mysql -u nextcloud -pnextcloud nextcloud < /dmp'

echo 'セカンダリのoccでフィンガープリントを更新する'
docker exec -u www-data $APP_CONTAINER_NAME_S php occ maintenance:data-fingerprint
