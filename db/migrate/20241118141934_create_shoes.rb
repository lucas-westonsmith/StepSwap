class CreateShoes < ActiveRecord::Migration[7.1]
  def change
    create_table :shoes do |t|
      t.string :brand
      t.integer :size
      t.string :condition
      t.decimal :price_per_day
      t.text :description
      t.boolean :availability
      t.string :shoe_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
