# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Shoe.destroy_all
# Create 10 shoe entries
10.times do
  shoe = Shoe.new(
    brand: Faker::Commerce.brand,
    size: Faker::Number.between(from: 36, to: 46), # Assuming sizes are between 36 and 46
    condition: ['new', 'used', 'worn'].sample, # Randomly select a condition
    price_per_day: Faker::Commerce.price(range: 10.0..50.0), # Price between 10 and 50
    description: Faker::Lorem.sentence(word_count: 10), # Random description
    availability: [true, false].sample, # Randomly assign availability
    shoe_url: "https://cdn.thewirecutter.com/wp-content/media/2024/05/running-shoes-2048px-9718.jpg", # Generate a random URL
    user_id: User.first.id # Associate the first user (or create your own user)
  )
  shoe.save
  puts "Created shoe: #{shoe.brand}, Size: #{shoe.size}, Price per day: $#{shoe.price_per_day}"
end
