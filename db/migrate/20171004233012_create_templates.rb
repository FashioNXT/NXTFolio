class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :type
      t.json :attribute

      t.timestamps
    end
  end
end
