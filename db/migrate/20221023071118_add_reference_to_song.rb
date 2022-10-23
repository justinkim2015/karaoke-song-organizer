class AddReferenceToSong < ActiveRecord::Migration[7.0]
  def change
    add_reference :songs, :user, null: false
  end
end
