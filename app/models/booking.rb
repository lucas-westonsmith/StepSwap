class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :shoe
  PAYMENT_METHODS = %w[credit_card paypal bank_transfer].freeze

  has_many :reviews, dependent: :destroy
  validates :start_date, :end_date, presence: true
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }
end
