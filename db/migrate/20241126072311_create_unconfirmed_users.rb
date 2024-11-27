class CreateUnconfirmedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :unconfirmed_users do |t|
      t.datetime :confirmation_sent_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :unconfirmed_email
      t.string :encrypted_password
      t.index :confirmation_token, unique: true
    end
  end
end
