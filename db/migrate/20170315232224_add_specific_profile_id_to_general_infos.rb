class AddSpecificProfileIdToGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :specific_profile_id, :integer
  end
end
