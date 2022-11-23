class AddArtistUrlToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :artist_url, :string
  end
end
