class AddCompanyToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :company, :string
  end
end
