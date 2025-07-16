class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

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
