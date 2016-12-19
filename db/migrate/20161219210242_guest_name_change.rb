class GuestNameChange < ActiveRecord::Migration
  def up
    rename_column :guests, :guest_name, :guest_fname
    add_column :guests, :guest_lname, :string, null: false
  end

  def down
    rename_column :guests, :guest_fname, :guest_name
    remove_column :guests, :guest_lname
  end
end
