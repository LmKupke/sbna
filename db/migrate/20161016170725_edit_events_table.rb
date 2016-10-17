class EditEventsTable < ActiveRecord::Migration
  def up
    rename_column :events, :start_date, :start
    add_column :events, :end, :datetime
    add_column :events, :allDay, :boolean, null: false, default: false
    add_column :events, :color, :string
  end

  def down
    remove_column :events, :color
    remove_column :events, :end
    rename_column :events, :start, :start_date
    remove_column :events, :allDay
  end
end
