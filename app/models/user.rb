class User < ApplicationRecord
  has_secure_password
  has_many :reports, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_reports, through: :favorites, source: :report
  has_one_attached :cover_image
  has_one_attached :icon

  def favorited?(report)
    favorites.exists?(report_id: report.id)
  end

  def favorite(report)
    favorites.create(report_id: report.id)
  end

  def unfavorite(report)
    favorites.find_by(report_id: report.id)&.destroy
  end
end
