class Mountain < ApplicationRecord
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w(name area feature level)
  end
  def self.ransackable_associations(auth_object = nil)
    %w(image_attachment image_blob)
  end
end
