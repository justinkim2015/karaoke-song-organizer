class RenameColumnsInPlace < ActiveRecord::Migration[7.0]
  def change
    rename_column :places, :lat, :latitude
    rename_column :places, :lng, :longitude
  end
end
