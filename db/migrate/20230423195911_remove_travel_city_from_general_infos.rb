class RemoveTravelCityFromGeneralInfos < ActiveRecord::Migration[6.1]
  def change
    remove_column :general_infos, :travel_city
    remove_column :general_infos, :travel_state 
    remove_column :general_infos, :travel_country
    remove_column :general_infos, :travel_start
    remove_column :general_infos, :travel_end
    remove_column :general_infos, :travel_details
  end
end
