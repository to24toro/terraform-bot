# terraform-bot

## terraformのインストール
brew install terraform

## ssh用のkeyを作成
既存のkeyではなく新しいkey-pairを作成する場合。

ssh-keygen -t rsa -f {ここにkey-pairに使う鍵の名前を入れる（とりあえず名前は`bot`にする）} -N ''

key-pairの名前を`bot`以外にするならec2.tfの該当箇所を変更すること。