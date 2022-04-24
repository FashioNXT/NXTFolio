class DropMessages < ActiveRecord::Migration[5.0]
  def change
    drop_table :messages
  end
end
