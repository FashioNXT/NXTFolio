class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      # t.references :follower, null: false
      # t.references :followee, null: false
      t.integer "follower_id", :null => false
      t.integer "followee_id", :null => false

      t.timestamps
    end
    # add_foreign_key :follows, :general_infos, column: follower
    # add_foreign_key :follows, :general_infos, column: followee
  end
end
