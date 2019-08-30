class AddLapTimeColumnsToLaps < ActiveRecord::Migration[5.2]
  def change
    add_column :laps, :lap_time_minutes, :integer
    add_column :laps, :lap_time_seconds, :integer
    add_column :laps, :lap_time_hundreds, :integer
  end
end
