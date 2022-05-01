class AddGeneralInfoIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :general_info_id, :integer
  end
end
