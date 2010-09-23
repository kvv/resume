# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100923003304) do

  create_table "resumes", :force => true do |t|
    t.string   "full_name"
    t.date     "birthday"
    t.string   "sex"
    t.string   "family"
    t.text     "education"
    t.text     "additional_education"
    t.text     "personal_qualities"
    t.text     "skills"
    t.string   "job"
    t.text     "experience"
    t.text     "additional_information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 40
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "perishable_token",                                 :default => "",    :null => false
    t.integer  "login_count",                                      :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.boolean  "active",                                           :default => false
    t.string   "city_name"
    t.decimal  "balance",           :precision => 10, :scale => 4, :default => 0.0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["city_name"], :name => "index_users_on_city_name"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
