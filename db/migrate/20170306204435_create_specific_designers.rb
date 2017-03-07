class CreateSpecificDesigners < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_designers do |t|
      t.text :genre     # concatenated strings.
      t.text :influencers
      t.text :specialties
      t.string :compensation
      t.string :experience
      t.timestamps
    end
  end
end
