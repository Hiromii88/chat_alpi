User.create!(
  name: "管理者ユーザー",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

require 'csv'

Mountain.delete_all

csv_path = Rails.root.join('db', 'mountains.csv')

CSV.foreach(csv_path, headers: true) do |row|
  mountain_data = row.to_h.slice(
    'name', 'height', 'level', 'feature', 'route_distance', 'prefecture', 'area'
  )
  Mountain.create!(mountain_data)
end

puts "CSVファイルのデータがDBにインポートされました！"
