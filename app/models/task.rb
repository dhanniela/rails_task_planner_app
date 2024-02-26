class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :due_date, presence: true
  validates :status, inclusion: { in: %w[pending completed] }
end
