class Task < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  scope :user_tasks, -> (user_id) { where(user_id: user_id) }
  scope :done_tasks, -> { where(done: true) }

  validates :name, presence: true
  validates :description, presence: true
end
