class AddLatAndLongToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :lat, :decimal
    add_column :places, :lng, :decimal
  end
end
