class AddProfdetailsToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :profdetails, :string
  end
end
