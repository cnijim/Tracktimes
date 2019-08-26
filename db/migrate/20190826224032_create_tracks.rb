class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :city
      t.string :state
      t.timestamps
    end
    add_index :tracks, :state
  end
end
