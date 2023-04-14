class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :name
      t.string :state_code
      t.float :latitude
      t.float :longitude
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
