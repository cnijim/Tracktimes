class CreateLaps < ActiveRecord::Migration[5.2]
  def change
    create_table :laps do |t|
      t.time :lap_time
      t.integer :track_id
      t.date :date
      t.integer :vehicle_id
      t.timestamps
    end
    add_index :vehicle_id, :track_id
  end
end
