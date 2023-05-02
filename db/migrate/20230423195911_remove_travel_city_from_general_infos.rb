class RemoveTravelCityFromGeneralInfos < ActiveRecord::Migration[6.1]
  def change
    if ActiveRecord::Base.connection.column_exists?(:general_infos, :travel_city)
      # do something if the column exists
      remove_column :general_infos, :travel_city
      remove_column :general_infos, :travel_state 
      remove_column :general_infos, :travel_country
      remove_column :general_infos, :travel_start
      remove_column :general_infos, :travel_end
    end
    
  end
end
