class AddEmailaddrToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :emailaddr, :string
  end
end
