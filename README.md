# terraform-bot

## terraformのインストール
```
brew install terraform
```

## ssh用のkeyを作成

既存のkeyではなく新しいkey-pairを作成する場合。
```
mkdir .ssh

ssh-keygen -t rsa -f bot -N ''

mv bot* .ssh
```

key-pairの名前を`bot`以外にするなら`ec2.tf`の該当箇所を変更すること。

## aws configure
`aws configure` を実行して認証情報を入力する。

```
cd bybit

terraform init

terraform apply
```

`.gitignore`に

```
bybit/.terraform*
bybit/terraform*
```
を追記。



### 削除するとき
```
cd bybit

terraform destroy
```

### 別のインスタンスを新たに立てるとき(例えば`gmo`というインスタンスをたてる)

```
cp bybit gmo

cd gmo
```

gmoディレクトリ内でbybitと名前が付いている部分を任意の名前に変更

```
terraform apply
```

.gitignoreに
```
gmo/.terraform*
gmo/terraform*
```
を追記。