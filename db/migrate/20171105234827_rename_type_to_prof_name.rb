class RenameTypeToProfName < ActiveRecord::Migration[5.0]
  def change
    rename_column :templates, :type, :prof_name
  end
end
