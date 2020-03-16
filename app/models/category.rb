class Category < ApplicationRecord
  has_many :subjects

  validates :code, presence: true, length: { maximum: 20 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true
end
