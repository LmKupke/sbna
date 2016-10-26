class Addpicture < ActiveRecord::Migration
  def up
    add_column :events, :picture, :string
  end

  def down
    remove_column :events, :picture, :string
  end
end
