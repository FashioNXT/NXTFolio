class AddNotificationToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :notification, :boolean, default: false
  end
end
