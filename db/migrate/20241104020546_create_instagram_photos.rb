class CreateInstagramPhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :instagram_photos do |t|
      t.references :user, foreign_key: true   # Adds a user_id column with an index
      t.string :url                           # URL of the Instagram photo
      t.string :caption                       # Caption of the photo
      t.datetime :posted_at                   # When the photo was posted

      t.timestamps
    end
  end
end
