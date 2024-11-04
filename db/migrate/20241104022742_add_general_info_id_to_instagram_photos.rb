class AddGeneralInfoIdToInstagramPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :instagram_photos, :general_info_id, :integer
    add_index :instagram_photos, :general_info_id
  end
end
