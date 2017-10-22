class RenameAttributesToProfAttribute < ActiveRecord::Migration[5.0]
  def change
    rename_column :templates, :attribute, :prof_attribute 
  end
end
