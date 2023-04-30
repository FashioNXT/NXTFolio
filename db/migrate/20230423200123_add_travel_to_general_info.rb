class AddTravelToGeneralInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :general_infos, :travel_country, :string
    add_column :general_infos, :travel_state, :string
    add_column :general_infos, :travel_city, :string
    add_column :general_infos, :travel_start, :date 
    add_column :general_infos, :travel_end, :date 
    add_column :general_infos, :travel_details, :string
  end
end
