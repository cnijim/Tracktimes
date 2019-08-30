class RemoveCountryFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :country, :integer
  end
end
