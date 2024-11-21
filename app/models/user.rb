class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_many :shoes
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar
  has_one :wishlist
  after_create :create_user_wishlist

  private

  def create_user_wishlist
    Wishlist.create(user: self)
  end
end
