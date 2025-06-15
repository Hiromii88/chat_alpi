#!/bin/bash

# ステップ1: 現在のコンテナ、イメージ、ボリュームの削除
echo "Cleaning up Docker containers, images, and volumes..."
docker-compose down
docker system prune -a --volumes

# ステップ2: プロジェクト内キャッシュの削除
echo "Clearing Rails tmp cache..."
rm -rf tmp/cache tmp/pids tmp/sockets tmp/storage
bundle exec rake tmp:cache:clear

# ステップ3: Gemfile.lockを削除して再インストール
echo "Removing Gemfile.lock and running bundle install..."
rm -f Gemfile.lock
bundle install

# ステップ4: Dockerイメージの再ビルド
echo "Rebuilding Docker images..."
docker-compose build --no-cache

# ステップ5: コンテナの起動
echo "Starting Docker containers..."
docker-compose up -d

# ステップ6: マイグレーションの実行
echo "Running database migrations..."
docker-compose run web rake db:migrate

# ステップ7: アセットのプリコンパイル（必要な場合）
echo "Precompiling assets..."
docker-compose run web rake assets:precompile

# ステップ8: ログの確認
echo "Checking logs..."
docker-compose logs -f
