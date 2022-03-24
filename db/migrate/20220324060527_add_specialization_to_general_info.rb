class AddSpecializationToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :specialization, :string
  end
end
