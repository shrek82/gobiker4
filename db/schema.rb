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

ActiveRecord::Schema.define(version: 20131229021443) do

  create_table "activities", force: true do |t|
    t.integer  "category_id"
    t.string   "address"
    t.text     "content"
    t.datetime "sign_start_at"
    t.datetime "sign_finish_at"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.integer  "sign_limit"
    t.boolean  "is_suspend",        default: false
    t.boolean  "is_stop_sign"
    t.boolean  "is_allow_everyone", default: false
    t.integer  "signed_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
  end

  add_index "activities", ["category_id"], name: "index_activities_on_category_id"
  add_index "activities", ["topic_id"], name: "index_activities_on_topic_id"

  create_table "activity_signs", force: true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.integer  "num_people"
    t.string   "intro"
    t.boolean  "is_anonymous", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_signs", ["activity_id"], name: "index_activity_signs_on_activity_id"
  add_index "activity_signs", ["user_id"], name: "index_activity_signs_on_user_id"

  create_table "ads", force: true do |t|
    t.string   "name"
    t.string   "js_path"
    t.string   "type"
    t.string   "img_path"
    t.string   "info"
    t.string   "url"
    t.integer  "hits"
    t.boolean  "is_close",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: true do |t|
    t.string   "name",           limit: 100
    t.integer  "user_id"
    t.integer  "place_id"
    t.integer  "activity_id"
    t.integer  "club_id"
    t.integer  "pics_num",                   default: 0
    t.integer  "hits_num",                   default: 0
    t.string   "tags",           limit: 100
    t.string   "cover_path",                 default: "/images/album_over.png"
    t.integer  "order_num"
    t.boolean  "is_close",                   default: false
    t.boolean  "is_recommended",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  add_index "albums", ["activity_id"], name: "index_albums_on_activity_id"
  add_index "albums", ["club_id"], name: "index_albums_on_club_id"
  add_index "albums", ["place_id"], name: "index_albums_on_place_id"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "areas", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pinyin"
    t.integer  "order_num"
  end

  add_index "areas", ["city_id"], name: "index_areas_on_city_id"

  create_table "article_categories", force: true do |t|
    t.string   "name"
    t.integer  "order_num"
    t.string   "img_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "tags"
    t.string   "intro"
    t.text     "content"
    t.string   "source"
    t.string   "img_path"
    t.string   "img_ids"
    t.integer  "hits_num"
    t.integer  "useful_num"
    t.integer  "comments_num"
    t.boolean  "is_recommended", default: false
    t.boolean  "is_fixed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["category_id"], name: "index_articles_on_category_id"
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "asks", force: true do |t|
    t.string   "title",          limit: 200
    t.string   "intro"
    t.integer  "province_id"
    t.string   "city_id"
    t.string   "tags",           limit: 50
    t.integer  "user_id"
    t.integer  "hits_num"
    t.integer  "answers_num"
    t.integer  "useful_num"
    t.integer  "base_answer_id"
    t.boolean  "is_resolved",                default: false
    t.boolean  "is_recommended",             default: false
    t.boolean  "is_fixed",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asks", ["user_id"], name: "index_asks_on_user_id"

  create_table "attacheds", force: true do |t|
    t.string   "name",             limit: 50
    t.string   "att",              limit: 100
    t.boolean  "is_verify"
    t.string   "att_file_name",    limit: 50
    t.string   "att_content_type", limit: 20
    t.integer  "att_file_size"
    t.datetime "att_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img",              limit: 100
    t.string   "img_file_name",    limit: 50
    t.string   "img_content_type", limit: 20
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.string   "img_path"
  end

  create_table "avatars", force: true do |t|
    t.integer  "user_id"
    t.string   "img",              limit: 150
    t.string   "img_path",         limit: 150
    t.string   "img_file_name",    limit: 100
    t.string   "img_content_type", limit: 50
    t.string   "img_file_size",    limit: 20
    t.datetime "img_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "avatars", ["user_id"], name: "index_avatars_on_user_id"

  create_table "been_to_places", force: true do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "been_to_places", ["place_id"], name: "index_been_to_places_on_place_id"
  add_index "been_to_places", ["user_id"], name: "index_been_to_places_on_user_id"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.integer  "order_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "pinyin"
    t.string   "img_path"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.integer  "route_id"
    t.integer  "topic_id"
    t.integer  "userful_num"
    t.integer  "activity_id"
    t.integer  "article_id"
    t.integer  "album_id"
  end

  add_index "comments", ["activity_id"], name: "index_comments_on_activity_id"
  add_index "comments", ["album_id"], name: "index_comments_on_album_id"
  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["place_id"], name: "index_comments_on_place_id"
  add_index "comments", ["route_id"], name: "index_comments_on_route_id"
  add_index "comments", ["topic_id"], name: "index_comments_on_topic_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "forums", force: true do |t|
    t.string   "name",        limit: 100
    t.string   "intro"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "club_id"
    t.integer  "topics_num",              default: 0
    t.integer  "order_num",               default: 999
    t.boolean  "is_systemic",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ico_path",    limit: 250, default: "/images/forum/default.png"
    t.integer  "category_id"
  end

  add_index "forums", ["category_id"], name: "category_idx"
  add_index "forums", ["city_id"], name: "city_idx"
  add_index "forums", ["club_id"], name: "club_idx"

  create_table "guide_categories", force: true do |t|
    t.string   "name"
    t.integer  "order_num"
    t.string   "img_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guides", force: true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "tags"
    t.string   "intro"
    t.text     "content"
    t.string   "source"
    t.string   "img_path"
    t.string   "img_ids"
    t.integer  "hits_num",       default: 0
    t.integer  "useful_num",     default: 0
    t.integer  "comments_num"
    t.boolean  "is_recommended", default: false
    t.boolean  "is_fixed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guides", ["category_id"], name: "index_guides_on_category_id"
  add_index "guides", ["user_id"], name: "index_guides_on_user_id"

  create_table "managers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "login_at"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.string   "name",       limit: 50
    t.string   "key_name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "action"
    t.string   "subject"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_users", id: false, force: true do |t|
    t.integer "permission_id"
    t.integer "user_id"
  end

  add_index "permissions_users", ["permission_id", "user_id"], name: "index_permissions_users_on_permission_id_and_user_id"
  add_index "permissions_users", ["user_id", "permission_id"], name: "index_permissions_users_on_user_id_and_permission_id"

  create_table "photos", force: true do |t|
    t.string   "title",            limit: 50
    t.string   "img_path",         limit: 250
    t.boolean  "is_verify",                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_file_name",    limit: 50
    t.string   "img_content_type", limit: 50
    t.string   "img_file_size",    limit: 50
    t.datetime "img_updated_at"
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "img"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"
  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "intro"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags"
    t.integer  "category_id"
    t.string   "img_path"
    t.string   "banner_path"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "source"
    t.integer  "been_num",       default: 0
    t.integer  "interested_num", default: 0
    t.integer  "favorites_num",  default: 0
    t.integer  "hits_num",       default: 0
    t.integer  "good_num",       default: 0
    t.boolean  "is_recommended", default: false
    t.boolean  "is_fixed",       default: false
    t.string   "map"
    t.integer  "area_id"
    t.string   "address"
    t.integer  "comments_num"
    t.string   "img_ids"
    t.integer  "rating"
    t.integer  "wantgoto_num",   default: 0
    t.integer  "beengo_num",     default: 0
  end

  add_index "places", ["category_id"], name: "index_places_on_category_id"
  add_index "places", ["is_recommended"], name: "index_places_on_is_recommended"
  add_index "places", ["province_id", "city_id"], name: "by_province_city"
  add_index "places", ["user_id"], name: "index_places_on_user_id"

  create_table "places_tags", id: false, force: true do |t|
    t.integer "place_id"
    t.integer "tag_id"
  end

  create_table "posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province_id"
    t.integer  "group"
    t.string   "pinyin"
  end

  create_table "recommends", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "img_path"
    t.integer  "order_num"
    t.string   "redirect"
    t.string   "intro"
    t.boolean  "is_close"
    t.boolean  "is_fixed"
    t.integer  "hits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_ids"
  end

  create_table "routes", force: true do |t|
    t.string   "title"
    t.string   "short_title"
    t.string   "tags"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "img_path"
    t.string   "banner_path"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "duration"
    t.integer  "distance"
    t.string   "starting"
    t.string   "destination"
    t.string   "intro"
    t.text     "content"
    t.string   "source"
    t.integer  "been_num"
    t.integer  "interested_num"
    t.integer  "favorites_num"
    t.integer  "hits_num"
    t.integer  "good_num"
    t.string   "along_the_scenic"
    t.boolean  "is_recommended"
    t.boolean  "is_fixed"
    t.integer  "recommendation_index"
    t.integer  "landscape_index"
    t.integer  "road_index"
    t.string   "map"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
    t.integer  "place_id"
    t.integer  "rating"
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "studies", force: true do |t|
    t.string   "name"
    t.string   "intro"
    t.boolean  "is_close"
    t.datetime "login_at"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_categories", force: true do |t|
    t.string   "name",       limit: 20
    t.integer  "order_num"
    t.string   "icon_path",  limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "togethers", force: true do |t|
    t.integer  "topic_id"
    t.datetime "sign_start_at"
    t.datetime "sign_finish_at"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.integer  "sign_limit"
    t.boolean  "is_closed"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
  end

  add_index "togethers", ["topic_id"], name: "index_togethers_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "title",                  limit: 150
    t.integer  "forum_id"
    t.integer  "subject_id",             limit: 2
    t.integer  "club_id"
    t.integer  "user_id"
    t.string   "title_color",            limit: 10
    t.boolean  "is_fixed",                           default: false
    t.boolean  "is_comment",                         default: false
    t.boolean  "is_good",                            default: false
    t.boolean  "is_recommend",                       default: false
    t.integer  "hits_num",                           default: 0
    t.integer  "comments_num",                       default: 0
    t.integer  "last_comment_user_id"
    t.string   "last_comment_user_name", limit: 50
    t.datetime "last_comment_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id"], name: "forum_idx"
  add_index "topics", ["is_good"], name: "is_goodx"
  add_index "topics", ["subject_id"], name: "subject_idx"
  add_index "topics", ["user_id"], name: "user_idx"

  create_table "tweets", force: true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.datetime "reg_date"
    t.datetime "login_date"
    t.string   "avatar_path"
    t.integer  "point"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "signatures"
  end

  create_table "want_to_places", force: true do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
