class AddAdminFieldToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :is_admin, :boolean
  end
end
