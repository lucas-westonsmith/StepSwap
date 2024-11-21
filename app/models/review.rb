class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true

  validates :booking_id, uniqueness: { scope: :user_id, message: "You can only leave one review per booking" }
end
