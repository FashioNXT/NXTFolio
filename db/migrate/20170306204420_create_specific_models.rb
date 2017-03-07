class CreateSpecificModels < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_models do |t|

      t.timestamps
    end
  end
end
