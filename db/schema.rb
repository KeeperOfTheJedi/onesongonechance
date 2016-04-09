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

ActiveRecord::Schema.define(version: 20160409040925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.integer  "blocker_id"
    t.integer  "blocked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "init_user_id"
    t.integer  "partner_user_id"
    t.datetime "exp_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "conversations", ["song_id"], name: "index_conversations_on_song_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "reporter_user_id"
    t.integer  "blamed_user_id"
    t.string   "message"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "song_lists", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "song_lists", ["song_id"], name: "index_song_lists_on_song_id", using: :btree
  add_index "song_lists", ["user_id"], name: "index_song_lists_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_pictures", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "picture_metas"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_pictures", ["user_id"], name: "index_user_pictures_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "conversations", "songs"
  add_foreign_key "song_lists", "songs"
  add_foreign_key "song_lists", "users"
  add_foreign_key "user_pictures", "users"
end
