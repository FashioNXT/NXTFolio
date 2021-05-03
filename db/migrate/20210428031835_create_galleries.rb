class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :gallery_title
      t.text :gallery_description
      t.string :gallery_picture, array:true
      t.float :gallery_totalRate
      t.integer :gallery_totalRator
      t.integer :GeneralInfo_id

      t.timestamps
    end
  end
end
