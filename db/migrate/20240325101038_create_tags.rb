class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.belongs_to :gallery, null: false, foreign_key: true
      t.text "body"
      t.timestamps
    end
  end
end
