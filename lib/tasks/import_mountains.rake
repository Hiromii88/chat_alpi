require 'csv'

namespace :import do
  desc "Import mountains from CSV"
  task mountains: :environment do
    Mountain.destroy_all

    csv_path = Rails.root.join('db/mountains.csv')

    CSV.foreach(csv_path, headers: true) do |row|
      Mountain.create!(
        name: row['name'],
        height: row['height'],
        level: row['level'],
        feature: row['feature'],
        route_distance: row['route_distance'],
        prefecture: row['prefecture'],
        area: row['area']
      )
    end

    puts "✅ mountain.csv のデータをインポートしました！"
  end
end
