class CreateSpecificDesigners < ActiveRecord::Migration[5.0]
  def change
    create_table :specific_designers do |t|

      t.timestamps
    end
  end
end
