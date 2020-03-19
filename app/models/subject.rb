class Subject < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
end
