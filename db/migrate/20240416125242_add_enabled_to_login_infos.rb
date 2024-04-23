class AddEnabledToLoginInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :login_infos, :enabled, :boolean, default: true
  end
end
