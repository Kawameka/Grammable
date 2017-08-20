class Gram < ApplicationRecord
  validates :message, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader

end
