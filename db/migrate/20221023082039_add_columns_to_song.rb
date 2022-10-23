class AddColumnsToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :artist, :string, null: false
  end
end
