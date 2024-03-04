class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :due_date, presence: true
  validates :status, inclusion: { in: %w[pending completed] }
  validate :due_date_cannot_be_in_the_past
  validate :scheduled_date_before_due_date

  private

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "cannot be in the past. Please select today's date or a future date.") if due_date.present? && due_date < Date.today
  end

  def scheduled_date_before_due_date
    if scheduled_date.present? && due_date.present? && scheduled_date > due_date
      errors.add(:scheduled_date, "must not be later than the due date.")
    elsif scheduled_date.present? && scheduled_date < Date.current
      errors.add(:scheduled_date, "must not be in the past. Please select today's date or a future date.")
    end
  end
end
