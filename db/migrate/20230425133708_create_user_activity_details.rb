class CreateUserActivityDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :user_activity_details do |t|
      t.integer :user_id
      t.datetime :logged_in_at
      t.datetime :last_active_at
      t.integer :time_spent_on_website

      t.timestamps
    end
  end
end
