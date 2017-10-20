class CreateNewprofessions < ActiveRecord::Migration[5.0]
  def change
    create_table :newprofessions do |t|

      t.timestamps
    end
  end
end
