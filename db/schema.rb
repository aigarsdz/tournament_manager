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

ActiveRecord::Schema.define(version: 2019_01_09_212108) do

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "first_team"
    t.integer "second_team"
    t.integer "first_score"
    t.integer "second_score"
    t.integer "winner"
    t.integer "division"
    t.string "first_team_name"
    t.string "second_team_name"
    t.index ["first_team"], name: "index_matches_on_first_team"
    t.index ["second_team"], name: "index_matches_on_second_team"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
