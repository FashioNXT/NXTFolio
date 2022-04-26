class AddChattingWithToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :chatting_with, :integer
  end
end
