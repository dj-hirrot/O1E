class Subject < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :tasks

  validates :name, presence: true
  validates :description, presence: true
end
