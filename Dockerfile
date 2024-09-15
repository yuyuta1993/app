# ベースイメージとして Ruby を使用
FROM ruby:3.1.0

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y nodejs libpq-dev

# 作業ディレクトリを作成
WORKDIR /app

# Gemfile と Gemfile.lock をコピー
COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock

# 必要なGemsをインストール
RUN bundle install

# アプリケーションのコードをコピー
COPY . /app

# サーバー起動前に server.pid ファイルを削除
RUN rm -f /app/tmp/pids/server.pid

# ポート3000を開放
EXPOSE 3000

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]

# libvipsのインストールを追加
RUN apt-get update && apt-get install -y libvips42