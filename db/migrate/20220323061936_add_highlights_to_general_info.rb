class AddHighlightsToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :highlights, :string
  end
end
