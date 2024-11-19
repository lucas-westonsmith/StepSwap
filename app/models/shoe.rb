class Shoe < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :brand, :size, :condition, :price_per_day, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
end
