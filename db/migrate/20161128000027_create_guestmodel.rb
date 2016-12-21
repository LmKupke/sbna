class CreateGuestmodel < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :user_id, null: false
      t.string :guest_name, null: false
      t.integer :event_id, null: false
    end
  end
end
