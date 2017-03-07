class CreateLoginInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :login_infos do |t|
      t.string :email
      t.string :password
      
      t.string :userKey
      #t.index :userKey , unique: true
      t.timestamps
    end
  end
end
