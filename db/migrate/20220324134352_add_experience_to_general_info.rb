class AddExperienceToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :experience, :string
  end
end
