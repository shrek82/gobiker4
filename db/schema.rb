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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140411151627) do

  create_table "logs", force: true do |t|
    t.string   "title",      limit: 150
    t.string   "controller", limit: 50
    t.string   "action",     limit: 50
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.integer  "forum_id"
    t.integer  "subject_id"
    t.string   "title",                limit: 150
    t.string   "title_color",          limit: 10
    t.integer  "user_id"
    t.boolean  "is_fixed"
    t.boolean  "is_good"
    t.boolean  "is_recommend"
    t.integer  "hits_num"
    t.integer  "comments_num"
    t.integer  "last_comment_user_id"
    t.datetime "last_comment_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id"], name: "index_topics_on_forum_id"
  add_index "topics", ["subject_id"], name: "index_topics_on_subject_id"
  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username",    limit: 50
    t.string   "password",    limit: 70
    t.string   "email",       limit: 80
    t.string   "avatar_path", limit: 150
    t.string   "memo"
    t.string   "signatures"
    t.integer  "point"
    t.datetime "reg_date"
    t.datetime "login_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
