class RemoveLapTimeFromLaps < ActiveRecord::Migration[5.2]
  def change
    remove_column :laps, :lap_time, :time
  end
end
