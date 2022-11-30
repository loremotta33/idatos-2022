# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_30_141935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string "player", null: false
    t.integer "ppg", default: 0, null: false
    t.integer "apg", default: 0, null: false
    t.integer "rpg", default: 0, null: false
    t.integer "spg", default: 0, null: false
    t.integer "bpg", default: 0, null: false
    t.integer "mvp", default: 0, null: false
    t.integer "finals_mvp", default: 0, null: false
    t.integer "per", default: 0, null: false
    t.integer "ws48", default: 0, null: false
    t.integer "campeonatos", default: 0, null: false
    t.integer "all_nba", default: 0, null: false
    t.integer "all_defense", default: 0, null: false
    t.integer "all_star", default: 0, null: false
    t.integer "ranking", default: 0, null: false
    t.string "basketball_reference_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
