class CreateJobInfo < ActiveRecord::Migration[6.1]
  def change
    create_table :job_infos do |t|
      t.string "title"
      t.string "description"
      t.string "category"
      t.string "profession"
      t.string "country"
      t.string "state"
      t.string "city"
      t.string "type"
      t.integer "low_salary"
      t.integer "high_salary"
      
      t.timestamps
    end
  end
end
