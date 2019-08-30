class AddCountryToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :country, :string
  end
end
