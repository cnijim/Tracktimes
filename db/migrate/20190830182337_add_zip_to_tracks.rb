class AddZipToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :zip, :integer
    add_column :tracks, :country, :integer
  end
end
