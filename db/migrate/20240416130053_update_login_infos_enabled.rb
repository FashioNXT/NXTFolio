class UpdateLoginInfosEnabled < ActiveRecord::Migration[6.1]
  def up
    change_column_default :login_infos, :enabled, true
  end

  def down
    change_column_default :login_infos, :enabled, nil
  end
end
