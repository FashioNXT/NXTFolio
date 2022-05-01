class AddGelleryIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :gellery_id, :integer
  end
end
