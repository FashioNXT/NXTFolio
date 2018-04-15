class AddLatitudeAndLongitudeToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :latitude, :float
    add_column :general_infos, :longitude, :float
  end
end
