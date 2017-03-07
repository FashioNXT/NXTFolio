class CreateSpecificPhotographers < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_photographers do |t|

      t.timestamps
    end
  end
end
