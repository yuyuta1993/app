# ベースイメージとして Ruby を使用
FROM ruby:3.0.2

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y nodejs mysql-client

# 作業ディレクトリを作成
WORKDIR /app

# Gemfile と Gemfile.lock をコピー
COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock

# 必要なGemsをインストール
RUN bundle install

# アプリケーションのコードをコピー
COPY . /app

# ポート3000を開放
EXPOSE 3000

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
