class AddIndustryToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :industry, :string
  end
end
