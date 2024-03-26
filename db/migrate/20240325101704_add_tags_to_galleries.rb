class AddTagsToGalleries < ActiveRecord::Migration[6.1]
  def change
    add_column :galleries, :tags, :text, default: [], array: true
  end
end
