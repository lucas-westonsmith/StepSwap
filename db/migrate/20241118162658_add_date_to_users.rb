class AddDateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :age, :date
  end
end
