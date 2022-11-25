class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|

      t.column :store_name, :string, null: false
      t.timestamps
    end
  end
end
