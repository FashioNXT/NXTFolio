class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :prof_name
      t.json :attribute

      t.timestamps
    end
  end
end
