class Subject < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :tasks

  validates :name, presence: true
  validates :description, presence: true

  def update_progress(user_id)
    _user_tasks = tasks.user_tasks(user_id)
    _num = _user_tasks.count
    _done_num = _user_tasks.done_tasks.count
    progress = (_done_num.to_f / _num.to_f) * 100
    update(progress: progress)
  end
end
