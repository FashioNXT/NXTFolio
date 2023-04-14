class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso3
      t.string :phone_code
      t.string :capital
      t.string :currency
      t.string :region
      t.string :subregion
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :countries, :iso3, unique: true
  end
end
