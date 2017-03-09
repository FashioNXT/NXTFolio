class AddUserKeyToSpecificDesigners < ActiveRecord::Migration[5.0]
  def change
    add_column :specific_designers, :user_key, :string
  end
end
