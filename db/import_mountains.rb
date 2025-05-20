# db/csv_import.rb

require 'csv'

# CSVファイルのパスを設定。Rails.root.joinで絶対パスを作成できます
csv_path = Rails.root.join('db', 'mountains.csv')

# CSVファイルを1行ずつ読み込み（ヘッダー行あり）
require 'csv'

CSV.foreach('db/mountains.csv', headers: true) do |row|
  mountain_data = row.to_h.slice(
    'name', 'height', 'level', 'feature', 'route_distance', 'prefecture'
  )
  Mountain.create!(mountain_data)
end

puts "CSVファイルのデータがDBにインポートされました！"
