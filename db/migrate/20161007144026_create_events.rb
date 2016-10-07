class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_date, null: false
      t.string :location, null: false
      t.text :description, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
