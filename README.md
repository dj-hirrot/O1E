<img src="https://github.com/dj-hirrot/O1E/blob/image/README/o1e_logo.png">
<h2 align="center">O1E WEB APP</h2>
<p align="center">
  <a href="https://rubyonrails.org/"><img src="https://github.com/dj-hirrot/O1E/blob/image/README/rails_logo.jpg" width="80px;" /></a>
  <br>
  <a href="https://jp.vuejs.org/index.html"><img src="https://github.com/dj-hirrot/O1E/blob/image/README/vue_logo.png" height="80px;" /></a>
  <a href="https://jp.heroku.com/"><img src="https://github.com/dj-hirrot/O1E/blob/image/README/heroku_logo.jpg" height="80px;" /></a>
  <a href="https://getbootstrap.com/"><img src="https://github.com/dj-hirrot/O1E/blob/image/README/bootstrap_logo.jpg" height="80px;" /></a>
  <a href="https://docs.rs/bcrypt/0.7.0/bcrypt/"><img src="https://github.com/dj-hirrot/O1E/blob/image/README/bcrypt_logo.jpg" height="80px;" /></a>
</p>

# 🍺 App URL
**PRODUCTION:** https://o1e.herokuapp.com/  
**STAGING:** https://o1e-stg.herokuapp.com/

# 🍺 Features
O1E は、興味のある科目を一覧で管理し、習得に必要な項目 (タスク) を科目ごとに登録し、管理することができるアプリです。

# 🍺 For developers
## How to Set Up Environments
### ローカル
リポジトリをクローンします。
```shell
$ git clone git@github.com:dj-hirrot/O1E.git
```
Originから `develop` と `release` をcheckoutします。
```shell
$ git checkout -b develop origin/develop
$ git checkout -b release origin/release
```
作業を開始する際は `develop` から `feature/` を接頭辞にもつ作業ブランチを派生させます。
ブランチ名は `feature/` + 作業する内容で命名してください。 (e.g. `feature/create_user_model`)
```shell
$ git checkout develop
$ git checkout -b feature/xxxx_xxxx_xxxx
```
ブランチを作成したあとは空のコミットをしてOriginにpushします。
```
$ git commit --allow-empty -m "first commit"
$ git push -u origin feature/xxxx_xxxx_xxxx
```
その後 `develop` に向けてPRを出します。

### GitHub
空の作業ブランチをpushしたらGitHub側でWIPステータスのPRを出します。
PR名は **[WIP] 一目で対応内容が分かるようなタイトル** で命名してください。

### Heroku
`develop` に向けてPRが出されるとHeroku側で自動的にアプリケーションが立ち上がります。
以降はこのReview Appを動作確認に使用してください。
