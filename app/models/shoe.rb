class Shoe < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  has_many :reviews, through: :bookings

  validates :brand, :size, :title, :condition, :price_per_day, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
end
