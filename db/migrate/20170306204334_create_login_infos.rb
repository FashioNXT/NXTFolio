class CreateLoginInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :login_infos do |t|

      t.timestamps
    end
  end
end
