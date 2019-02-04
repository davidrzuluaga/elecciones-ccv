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

ActiveRecord::Schema.define(version: 2019_01_15_321212) do

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "picture_url"
    t.integer "position_id"
    t.integer "election_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_candidates_on_election_id"
    t.index ["position_id"], name: "index_candidates_on_position_id"
  end

  create_table "codes", force: :cascade do |t|
    t.string "code"
    t.boolean "used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elections", force: :cascade do |t|
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "election_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_groups_on_election_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_positions_on_group_id"
  end

  create_table "voters", force: :cascade do |t|
    t.integer "identification"
    t.boolean "voted"
    t.integer "election_id"
    t.integer "group_id"
    t.integer "code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_id"], name: "index_voters_on_code_id"
    t.index ["election_id"], name: "index_voters_on_election_id"
    t.index ["group_id"], name: "index_voters_on_group_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "code_id"
    t.integer "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["code_id"], name: "index_votes_on_code_id"
    t.index ["position_id"], name: "index_votes_on_position_id"
  end

end
