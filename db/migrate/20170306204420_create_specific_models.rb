class CreateSpecificModels < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_models do |t|
      t.integer :height_feet
      t.integer :height_inches
      t.integer :bust
      t.integer :waist
      t.integer :hips
      t.string :cups
      t.integer :shoe_size
      t.integer :dress_size
      
      t.string :hair_color
      t.string :eye_color
      t.string :ethnicity
      t.string :skin_color
      t.string :shoot_nudes
      t.string :tattoos
      t.string :piercings
      t.string :experience
      t.text :genre
      
      t.timestamps
    end
  end
end
