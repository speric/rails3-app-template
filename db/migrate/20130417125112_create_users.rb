class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address, :null => false
      t.boolean :admin, :default => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.string :perishable_token, :null => false
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :single_access_token
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.timestamps
    end
    
    add_index :users, :email_address
    add_index :users, :persistence_token
    add_index :users, :single_access_token, :unique => true
    add_index :users, :perishable_token
  end
end