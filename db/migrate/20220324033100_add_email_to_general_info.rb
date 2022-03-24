class AddEmailToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :email, :string
  end
end
