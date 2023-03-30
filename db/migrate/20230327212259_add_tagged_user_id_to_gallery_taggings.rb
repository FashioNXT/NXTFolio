class AddTaggedUserIdToGalleryTaggings < ActiveRecord::Migration[6.1]
  def change
    add_column :gallery_taggings, :tagged_user_id, :integer
  end
end
