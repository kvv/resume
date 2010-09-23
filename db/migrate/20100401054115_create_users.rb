class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # --------- authlogic
      t.string   :login, :email, :crypted_password, :password_salt,
                 :persistence_token, :last_login_ip, :current_login_ip

      t.string   :perishable_token, :default => '', :null => false
      t.integer  :login_count, :default => 0, :null => false
      t.datetime :last_request_at, :last_login_at, :current_login_at
      t.boolean  :active, :default => false
      # --------- end authlogic

      t.string  :city_name
      t.decimal :balance, :precision => 10, :scale => 4, :null => false, :default => 0 # баланс пользователя (остаток)

      t.timestamps
    end

    # ---------- Roles
    create_table :roles do |t|
      t.string  :name,   :limit => 40
    end

    create_table :roles_users, :id => false, :force => true do |t|
      t.references  :user
      t.references  :role
    end
    # ----------end Roles

    add_index :users, :email
    add_index :users, :city_name
    add_index :users, :persistence_token
    add_index :users, :last_request_at
    add_index :users, :perishable_token

  end

  def self.down
    drop_table :users
    drop_table :roles
    drop_table :roles_users

    remove_index :users, :email
    remove_index :users, :city_name
    remove_index :users, :persistence_token
    remove_index :users, :last_request_at
    remove_index :users, :perishable_token

  end
end

