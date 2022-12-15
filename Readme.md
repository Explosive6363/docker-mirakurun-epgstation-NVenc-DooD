# docker-mirakurun-epgstation
[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

> **Warning**  
>  Forkの追加事項  
### テキトウな構成図
![Build Server](https://user-images.githubusercontent.com/49982049/207947352-4e5c426c-718f-4342-a255-e2058b713f93.jpeg)


## マストでやらなければいけないこと
### nvidia-dockerの導入
[ドキュメント - Nvidia](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)を読んで導入してください。

### pathの変更
`epgstation/config/enc_nvenc.sh`の`${FULL_PATH}`の部分を`/app/recorded`のマウント元のフルパスに置き換えてください。  
私の環境では `/home/possive/docker-mirakurun-epgstation-NVenc-DooD/recorded`に書き換えました。

## オプション
### エンコードオプションの変更
`epgstation/config/enc_nvenc.sh`をよしなに修正してください。  
現状H.264にテキトウにエンコードしています。

> **Warning**  
>  ここまで  
<br>
<br>
<br>
## 前提条件

- Docker, docker-compose の導入が必須
- ホスト上の pcscd は停止する
- チューナーのドライバが適切にインストールされていること

## インストール手順

```sh
curl -sf https://raw.githubusercontent.com/l3tnun/docker-mirakurun-epgstation/v2/setup.sh | sh -s
cd docker-mirakurun-epgstation

#チャンネル設定
vim mirakurun/conf/channels.yml

#コメントアウトされている restart や user の設定を適宜変更する
vim docker-compose.yml
```

## 起動

```sh
sudo docker-compose up -d
```

## チャンネルスキャン地上波のみ(取得漏れが出る場合もあるので注意)

```sh
curl -X PUT "http://localhost:40772/api/config/channels/scan"
```

mirakurun の EPG 更新を待ってからブラウザで http://DockerHostIP:8888 へアクセスし動作を確認する

## 停止

```sh
sudo docker-compose down
```

## 更新

```sh
# mirakurunとdbを更新
sudo docker-compose pull
# epgstationを更新
sudo docker-compose build --pull
# 最新のイメージを元に起動
sudo docker-compose up -d
```

## 設定

### Mirakurun

* ポート番号: 40772

### EPGStation

* ポート番号: 8888
* ポート番号: 8889

### 各種ファイル保存先

* 録画データ

```./recorded```

* サムネイル

```./epgstation/thumbnail```

* 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

* EPGStation 設定ファイル

```./epgstation/config```

* EPGStation のログ

```./epgstation/logs```

## v1からの移行について

[docs/migration.md](docs/migration.md)を参照
