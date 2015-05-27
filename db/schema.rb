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

ActiveRecord::Schema.define(version: 20150527180207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bat_statlines", force: :cascade do |t|
    t.integer  "bat_id"
    t.integer  "g"
    t.integer  "pa"
    t.integer  "ab"
    t.integer  "h"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "hr"
    t.integer  "r"
    t.integer  "rbi"
    t.integer  "bb"
    t.integer  "so"
    t.integer  "hbp"
    t.integer  "sb"
    t.integer  "cs"
    t.float    "avg"
    t.float    "obp"
    t.float    "slg"
    t.float    "ops"
    t.float    "woba"
    t.float    "fld"
    t.float    "bsr"
    t.float    "war"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bats", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "team_name",     null: false
    t.integer  "mlb_player_id"
    t.integer  "team_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "bats", ["mlb_player_id"], name: "index_bats_on_mlb_player_id", using: :btree
  add_index "bats", ["name", "team_name"], name: "index_bats_on_name_and_team_name", using: :btree

  create_table "competitors", force: :cascade do |t|
    t.integer  "team_id"
    t.float    "off_expected_war"
    t.float    "sp_expected_war"
    t.float    "rp_expected_war"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "favorite_id"
    t.integer  "underdog_id"
    t.float    "sportsbook_odds"
    t.float    "our_odds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pit_statlines", force: :cascade do |t|
    t.integer  "pit_id",     null: false
    t.integer  "w"
    t.integer  "l"
    t.float    "era"
    t.integer  "gs"
    t.integer  "g"
    t.float    "ip"
    t.integer  "h"
    t.integer  "er"
    t.integer  "hr"
    t.integer  "so"
    t.integer  "bb"
    t.float    "whip"
    t.float    "k_per_9"
    t.float    "bb_per_9"
    t.float    "fip"
    t.float    "war"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "source"
  end

  create_table "pits", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "team_name",     null: false
    t.integer  "mlb_player_id"
    t.boolean  "reliever"
    t.integer  "team_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "pits", ["mlb_player_id"], name: "index_pits_on_mlb_player_id", using: :btree
  add_index "pits", ["name", "team_name"], name: "index_pits_on_name_and_team_name", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
