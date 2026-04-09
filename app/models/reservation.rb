class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_date, presence: true
  validates :checkout_date, presence: true, comparison: { greater_than: :checkin_date }
  validates :people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
