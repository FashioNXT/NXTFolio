class AddPhoneNumberToGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :phone, :string
  end
end
