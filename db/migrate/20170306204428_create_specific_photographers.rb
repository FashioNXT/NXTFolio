class CreateSpecificPhotographers < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_photographers do |t|
      t.string :compensation
      t.string :experience
      t.text :influencers
      t.text :specialties
      t.text :genre
      t.timestamps

    end
  end
end
