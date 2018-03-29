class AddStateToSpecificPhotographers < ActiveRecord::Migration[5.0]
  def change
  	add_column :specific_photographers, :state, :string
  end
end
