class AddAttendeeId < ActiveRecord::Migration
  def up
    add_column :guests, :attendee_id, :integer, null: false
    remove_column :guests, :user_id
  end

  def down
    add_column :guests, :user_id, :integer
    remove_column :guests, :attendee_id
  end
end
