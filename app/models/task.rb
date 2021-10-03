class Task < ApplicationRecord
  belongs_to :user

  validates :description, :start_date, :end_date, presence: true
  validate :start_and_end_date

  private

  def start_and_end_date
    return if start_date.nil? || end_date.nil?

    if start_date > end_date
      errors.add(:end_date, "cannot be before start_date")
    end
  end
end
