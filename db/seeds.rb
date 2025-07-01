# 💥 先に Report を削除しないと Mountain.delete_all で外部キーエラーになる！
Report.delete_all
Mountain.delete_all

# ユーザー3名を作成（管理者含む）
users = [
  { name: "管理者ユーザー", email: "admin@example.com", admin: true },
  { name: "テストユーザーA", email: "user1@example.com", admin: false },
  { name: "テストユーザーB", email: "user2@example.com", admin: false }
]

users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.name = user_data[:name]
    user.password = "password"
    user.password_confirmation = "password"
    user.admin = user_data[:admin]
  end
end

puts "ユーザー3名を作成しました"

# 山データのインポート（CSV）
require 'csv'

Mountain.delete_all

csv_path = Rails.root.join('db', 'mountains.csv')

CSV.foreach(csv_path, headers: true) do |row|
  mountain_data = row.to_h.slice(
    'name', 'height', 'level', 'feature', 'route_distance', 'prefecture', 'area'
  )
  Mountain.create!(mountain_data)
end

puts "CSVファイルの山データをインポートしました"

# 🌟 各ユーザーにダミーレポートを5件ずつ作成
mountain = Mountain.first || Mountain.create!(name: "仮の山", height: 1000, level: "初級", feature: "仮の特徴", route_distance: "5km", prefecture: "不明", area: "不明")

User.all.each do |user|
  5.times do |i|
    Report.create!(
      user: user,
      mountain: mountain,
      title: "#{user.name}のレポート#{i + 1}",
      content: "これは#{user.name}の#{i + 1}件目のダミーレポートです。\nCT:#{7 + i}時間"
    )
  end
end

puts "各ユーザーに5件ずつ山レポートを作成しました（合計#{User.count * 5}件）"
