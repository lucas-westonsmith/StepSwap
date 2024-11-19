class ChangeAgeToDateOfBirthInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :age, :date_of_birth
  end
end
