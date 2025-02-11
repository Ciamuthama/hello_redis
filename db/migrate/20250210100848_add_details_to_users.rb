class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :full_name, :string
    add_column :users, :location, :string
    add_column :users, :date_of_birth, :date
  end
end
