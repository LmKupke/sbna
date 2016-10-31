class AddSpotstoEvents < ActiveRecord::Migration
  def up
    add_column :events, :max_participants, :integer
  end

  def down
    remove_column :events, :max_participants, :integer
  end
end
