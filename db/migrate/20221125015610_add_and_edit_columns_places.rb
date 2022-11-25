class AddAndEditColumnsPlaces < ActiveRecord::Migration[7.0]
  def change
    rename_column :places, :store_name, :name
    add_column :places, :place_id, :string, null: false
    add_reference :places, :user
  end
end
