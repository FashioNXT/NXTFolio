class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :prof_name
      t.json :prof_attribute

      t.timestamps
    end

    change_table :templates do |t|
      t.rename :attribute, :prof_attribute
    end
  end
end
