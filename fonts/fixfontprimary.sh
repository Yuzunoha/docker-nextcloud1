#!/bin/sh

# 定数宣言
readonly BASE_DIR='/home/yuzunoha/git/docker-nextcloud1'
readonly FONTS_DIR=$BASE_DIR'/fonts'
readonly APP_CONTAINER_NAME_P='primary_app_1'

echo '日本語フォントをプライマリコンテナに転送する'
docker cp $FONTS_DIR/NotoSans-Regular.ttf \
  $APP_CONTAINER_NAME_P:/var/www/html/core/fonts/NotoSans-Regular.ttf
