class AddTestPictureToGalleries < ActiveRecord::Migration[6.1]
  def change
    add_column :galleries, :string, array:true
  end
end
