class RemoveNotificationFromFromGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    remove_column :general_infos, :notification_from, :string
  end
end
