class AddCoumnIsAdminLoginInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :login_infos, :is_admin, :string
  end
end
