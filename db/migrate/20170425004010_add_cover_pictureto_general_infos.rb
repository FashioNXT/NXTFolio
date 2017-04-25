class AddCoverPicturetoGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :cover_picture, :string
  end
end
