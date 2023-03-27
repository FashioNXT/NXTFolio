class CreateGalleryTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_taggings do |t|
      t.references :gallery, null: false, foreign_key: true
      t.references :general_info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
