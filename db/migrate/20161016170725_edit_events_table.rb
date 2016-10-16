class EditEventsTable < ActiveRecord::Migration
  def up
    rename_column :events, :start_date, :start
    add_column :events, :end, :datetime, null: false
    add_column :events, :allDay, :boolean, null: false, default: false
  end

  def down
    remove_column :events, :end_date
    rename_column :events, :start, :start_date
    remove_column :events, :allDay
  end
end
