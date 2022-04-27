class AddNotificationFromToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :notification_from, :integer, array: true, default: []
  end
end
