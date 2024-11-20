class AddTitleToShoes < ActiveRecord::Migration[7.1]
  def change
    add_column :shoes, :title, :string
  end
end
