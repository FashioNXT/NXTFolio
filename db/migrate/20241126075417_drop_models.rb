class DropModels < ActiveRecord::Migration[6.1]
  def change
    drop_table :models
  end
end
