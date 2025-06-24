class User < ApplicationRecord
  has_secure_password
  has_many :reports
  has_many :favorites
  has_many :favorited_reports, through: :favorites, source: :report
  has_one_attached :cover_image
  has_one_attached :icon
end
