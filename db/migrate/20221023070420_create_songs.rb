class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|

      t.column :title, :string, null: false
      t.timestamps
    end
  end
end
