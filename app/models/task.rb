class Task < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
end
