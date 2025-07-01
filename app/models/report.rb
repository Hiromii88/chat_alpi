class Report < ApplicationRecord
  belongs_to :user
  belongs_to :mountain, optional: true
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[title content user_id mountain_id created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    %w[user mountain favorites favorited_by_users image_attachment image_blob]
  end
end
