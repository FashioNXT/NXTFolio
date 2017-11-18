class RenameTypeToProfName < ActiveRecord::Migration[5.0]
  def change
    if column_exists?(:templates, :type)
      rename_column :templates, :type, :prof_name
    end
  end
end
