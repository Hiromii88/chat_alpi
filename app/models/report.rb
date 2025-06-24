class Report < ApplicationRecord
  belongs_to :user
  belongs_to :mountain
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user
end
