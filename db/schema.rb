# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121112225143) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name",                                  :null => false
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "allow_signup",       :default => false, :null => false
    t.boolean  "allow_teams",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
  end

  create_table "teams", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "event_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_event_teams", :force => true do |t|
    t.integer  "event_id",   :null => false
    t.integer  "user_id",    :null => false
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_event_teams", ["user_id", "event_id", "team_id"], :name => "index_user_event_teams_on_user_id_and_event_id_and_team_id", :unique => true
  add_index "user_event_teams", ["user_id", "event_id"], :name => "index_user_event_teams_on_user_id_and_event_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
