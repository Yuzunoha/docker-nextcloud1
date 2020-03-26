# docker-nextcloud1


## 概要
- 練習


## 参考
- [NextcloudをDockerで構築する手順][link1]


## ThinkPadでの練習
- usbメモリと直挿しのsdカードをそれぞれexfatでフォーマットしてマウントすることに成功
- 自動マウントは未設定。本番は自動マウントを設定しよう
- metadataのバックアップは可能なのだろうか。まあ別にいい気もする
- あと暗号化はどこでやるのだろうか。ホスト側のosだろうか
  - ホスト側でluksでパ薄ワードによる暗号化でよさそう
  - luksもrsyncも枯れた技術らしい
- 履歴の件も考える
- sslはホスト側で設定するのだろう
- rsyncとcronで差分バックアップできそう
  - rsyncの差分バックアップ(uオプション)で世話なさそう
    - rsync -auv dir1/ backup/

## プレビュー文字化け対策
- プライマリをセットアップまでやったら下記を実行する
  - sudo ./fonts/fixfontprimary.sh

[link1]:https://www.virment.com/setup-nextcloud-docker/