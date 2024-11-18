class Shoe < ApplicationRecord
  belongs_to :user

  validates :brand, :size, :condition, :price_per_day, :availability, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
end
