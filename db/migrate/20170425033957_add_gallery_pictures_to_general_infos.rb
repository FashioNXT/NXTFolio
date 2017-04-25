class AddGalleryPicturesToGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :gallery_pictures, :string, array:true
  end
end
