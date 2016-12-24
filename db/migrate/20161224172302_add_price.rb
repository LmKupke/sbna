class AddPrice < ActiveRecord::Migration
  def up
    add_column :events, :price, :float, default: 0, null: false
  end

  def down
    remove_column :events, :price
  end
end
