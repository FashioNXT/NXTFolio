class CreateGeneralInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :general_infos do |t|
      t.string :userKey
      t.string :first_name
      t.string :last_name
      
      #t.string :date_of_birth
      t.integer :month_ofbirth
      t.integer :day_ofbirth
      t.integer :year_ofbirth
      t.string :gender
      t.string :company
      t.string :highlights
      t.string :industry
      t.string :country
      t.string :state
      t.string :city
      
      t.string :compensation
      t.string :facebook_link
      t.string :linkedIn_link
      t.string :instagram_link
      t.string :personalWebsite_link
      
      t.text :bio
      
      t.timestamps
    end
  end
end
