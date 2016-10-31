class AddProfilePic < ActiveRecord::Migration
  def up
    add_column :users, :profphoto, :string
  end

  def down
    remove_column :users, :profphoto, :string
  end
end
