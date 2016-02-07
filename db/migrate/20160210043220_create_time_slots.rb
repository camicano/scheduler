class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :coach_id
      t.integer :client_id
      t.integer :hour
      t.datetime :date

      t.timestamps null: false
    end
  end
end
