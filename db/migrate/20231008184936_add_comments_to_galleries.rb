class AddCommentsToGalleries < ActiveRecord::Migration[6.1]
  def change
    add_column :galleries, :comments, :text, array: true, default: []
  end
end
