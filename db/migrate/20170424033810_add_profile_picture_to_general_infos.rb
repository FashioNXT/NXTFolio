class AddProfilePictureToGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :profile_picture, :string
  end
end
