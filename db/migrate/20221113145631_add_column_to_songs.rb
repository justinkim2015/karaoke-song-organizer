class AddColumnToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :lyrics_url, :string
  end
end
