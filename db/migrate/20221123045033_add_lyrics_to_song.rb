class AddLyricsToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :lyrics, :text
  end
end
