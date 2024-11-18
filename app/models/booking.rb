class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :shoe

  has_one :review, dependent: :destroy
  validates :start_date, :end_date, :status, presence: true
end
