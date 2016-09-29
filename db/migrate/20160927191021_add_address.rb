class AddAddress < ActiveRecord::Migration
  def change
    add_column :users, :street, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :zipcode, :integer, null: false
    add_column :users, :other_address, :string
  end
end
