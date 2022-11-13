class AddReferencesToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :genius_id, :integer
  end
end
