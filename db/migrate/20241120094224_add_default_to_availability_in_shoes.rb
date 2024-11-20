class AddDefaultToAvailabilityInShoes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :shoes, :availability, from: nil, to: true
  end
end
